import 'package:dona_josy/components/AppBar.dart';
import 'package:dona_josy/pages/Cart.dart';
import 'package:dona_josy/pages/Cosmetics.dart';
import 'package:dona_josy/pages/Lunchboxes.dart';
import 'package:dona_josy/pages/Profile.dart';
import 'package:dona_josy/store/cart.store.dart';
import 'package:dona_josy/store/home.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeStore>(context, listen: false).getProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<HomeStore>(context);
    final pages = [
      Cosmetics(isAdmin: store.isAdmin),
      Lunchboxes(isAdmin: store.isAdmin),
      Cart(isAdmin: store.isAdmin),
      // const Assistant(),
      const Profile(),
    ];

    return Observer(
      builder: (context) => Scaffold(
        appBar: const AppBarDonaJosy(nameScreen: 'Dona Josy'),
        body: store.isRoleLoaded
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IndexedStack(
                  index: store.selectedIndex,
                  children: pages,
                ),
              )
            : const Center(child: CircularProgressIndicator()),
        bottomNavigationBar: Observer(
          builder: (context) {
            final cartStore = Provider.of<CartStore>(context);
            return SizedBox(
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: store.selectedIndex,
                onTap: store.setIndexScreen,
                items: store.optionsMenu.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  final icon = FaIcon(option['icon']);

                  if (index == 2) {
                    return BottomNavigationBarItem(
                      icon: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: icon,
                          ),
                          if (cartStore.totalElements > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 18,
                                  minHeight: 18,
                                ),
                                child: Text(
                                  '${cartStore.totalElements}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      label: option['label'],
                    );
                  }

                  return BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: icon,
                    ),
                    label: option['label'],
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

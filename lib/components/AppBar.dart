import 'dart:async';

import 'package:dona_josy/pages/Login.dart';
import 'package:dona_josy/services/api/auth.dart';
import 'package:dona_josy/store/home.store.dart';
import 'package:dona_josy/utils/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarDonaJosy extends StatefulWidget implements PreferredSizeWidget {
  const AppBarDonaJosy({super.key, required this.nameScreen, this.setLabel});
  final String nameScreen;
  final Function(dynamic)? setLabel;

  @override
  State<AppBarDonaJosy> createState() => _AppBarDonaJosyState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarDonaJosyState extends State<AppBarDonaJosy> {
  // LeroyApi leroyApi = LeroyApi();
  // ResaleApi resaleApi = ResaleApi();
  final TextEditingController labelSelected = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      showDialog<String>(
        context: context,
        builder: (BuildContext dialogContext) => AlertDialog(
              title: const Text('Deseja mesmo sair?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, 'Não'),
                  child: const Text('Não'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);
                    final token = await Shared().get('access');
                    await Shared().clearAuthentication();
                    if (!mounted) return;
                    final homeStore = context.read<HomeStore>();
                    homeStore.setAdmin(false);
                    homeStore.setRoleLoaded(false);
                    homeStore.setIndexScreen(0);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const Login()),
                      (_) => false,
                    );
                    if (token != null) {
                      unawaited(
                        AuthApi()
                            .logout(token: token, clearLocal: false)
                            .then<void>((_) {})
                            .catchError((_) {}),
                      );
                    }
                  },
                  child: const Text('Sim'),
                ),
              ],
            ),
        );
    }

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Center(
        child: Text(
          'DONA JOSY',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      elevation: 3.0,
      leading: Container(
        margin: EdgeInsets.only(left: 20.0),
        child: Image.asset('assets/images/logo_dona_josy.png', height: 100.0),
      ),
      actions: [
        IconButton(
          onPressed: logout,
          icon: Icon(Icons.exit_to_app, color: Colors.white),
        ),
        SizedBox(width: 15.0),
      ],
    );
  }
}

import 'package:dona_josy/config/app_env.dart';
import 'package:dona_josy/pages/Login.dart';
import 'package:dona_josy/store/login.store.dart';
import 'package:dona_josy/store/cart.store.dart';
import 'package:dona_josy/store/cosmetic.store.dart';
import 'package:dona_josy/store/home.store.dart';
import 'package:dona_josy/store/assistant.store.dart';
import 'package:dona_josy/store/lunchboxe.store.dart';
import 'package:dona_josy/store/profile.store.dart';
import 'package:dona_josy/store/register.store.dart';
import 'package:dona_josy/utils/colors/colors.dart';
import 'package:dona_josy/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnv.load();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: pinkApp,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => HomeStore()),
        Provider(create: (_) => AssistantStore()),
        Provider(create: (_) => CosmeticStore()),
        Provider(create: (_) => LunchboxeStore()),
        Provider(create: (_) => CartStore()),
        Provider(create: (_) => ProfileStore()),
        Provider(create: (_) => LoginStore()),
        Provider(create: (_) => RegisterStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Dona Josy',
        theme: themeData,
        home: Login(),
      ),
    );
  }
}

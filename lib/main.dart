import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nanny/screens/register_screen.dart';
import 'package:nanny/service/locator_service.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';
import 'package:nanny/viewmodel/register_view_model.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<INanniesViewModel>(
          create: (_) => NanniesViewModel(repo: sl.get())
            ..listenToNannies()
            ..listenToAuthState(),
        ),
        ChangeNotifierProvider<INannyViewModel>(
            create: (_) => NannyViewModel(repo: sl.get())),
        ChangeNotifierProvider<IRegisterViewModel>(
          create: (_) => RegisterViewModel(repo: sl.get()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('uk'),
        Locale('ru'),
        Locale('en'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'nannies',
      routes: {
        NanniesScreen.id: (context) => const NanniesScreen(),
        FilterScreen.id: (context) => const FilterScreen(),
        NannyScreen.id: (context) => const NannyScreen(),
        NannyScreen.id: (context) => const NannyScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
      },
    );
  }
}

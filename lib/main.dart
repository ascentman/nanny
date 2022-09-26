import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nanny/firebase_options.dart';
import 'package:nanny/screens/city_screen.dart';
import 'package:nanny/screens/nannies_screen/components/dismiss_keyboard.dart';
import 'package:nanny/screens/prices_screen.dart';
import 'package:nanny/service/firebase_analytics_screen.dart';
import 'package:nanny/service/locator_service.dart';
import 'package:nanny/service/remote_config_service.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:nanny/viewmodel/nanny_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/screens.dart';

String initScreen = StartScreen.id;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('showNannies') ?? false) {
    initScreen = NanniesScreen.id;
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  setupLocator();
  await sl<IRemoteConfigService>().fetchUpdates();
  await sl<IAnalyticsService>().logEvent('app-started');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<INanniesViewModel>(
          create: (_) => NanniesViewModel(repo: sl.get(), timeRepo: sl.get()),
        ),
        ChangeNotifierProvider<INannyViewModel>(
            create: (_) => NannyViewModel(repo: sl.get(), timeRepo: sl.get())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
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
        title: 'UA kids: няня',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: initScreen,
        routes: {
          StartScreen.id: (context) => const StartScreen(),
          NanniesScreen.id: (context) => const NanniesScreen(),
          FilterScreen.id: (context) => const FilterScreen(),
          CityScreen.id: (context) => const CityScreen(),
          NannyScreen.id: (context) => const NannyScreen(),
          NannyScreen.id: (context) => const NannyScreen(),
          AboutUsScreen.id: (context) => const AboutUsScreen(),
          ContactUsScreen.id: (context) => const ContactUsScreen(),
          BookingConfirmScreen.id: (context) =>
              BookingConfirmScreen(analytics: sl.get()),
          TutorialScreen.id: (context) => const TutorialScreen(),
          PricesScreen.id: (context) => PricesScreen(
                remoteConfigService: sl.get(),
              ),
        },
      ),
    );
  }
}

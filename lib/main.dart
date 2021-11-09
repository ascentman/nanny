import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nanny/main/nannies_screen.dart';
import 'package:nanny/service/locator_service.dart';
import 'package:nanny/viewmodel/nannies_view_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<INanniesViewModel>(
      create: (_) => NanniesViewModel(repo: sl.get()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NanniesScreen(),
    );
  }
}

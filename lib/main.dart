import 'package:flutter/material.dart';
import 'package:toka_test/screens/details_screen.dart';
import 'package:toka_test/screens/login_screen.dart';
import 'package:toka_test/screens/people_list_screen.dart';
import 'package:toka_test/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        PeopleListScreen.id: (context) => const PeopleListScreen(),
        DetailsScreen.id: (context) => const DetailsScreen(),
      },
    );
  }
}

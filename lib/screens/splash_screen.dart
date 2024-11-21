import 'package:flutter/material.dart';
import 'package:toka_test/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getData() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          getData();
        },
        child: Center(
          child: Image.asset('assets/images/logo.jpg'),
        ),
      ),
    );
  }
}

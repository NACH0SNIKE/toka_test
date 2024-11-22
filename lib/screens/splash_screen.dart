import 'package:flutter/material.dart';
import 'package:toka_test/helpers/database_helper.dart';
import 'package:toka_test/screens/contacts_screen.dart';
import 'package:toka_test/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    print(user);

    if (user != null) {
      // User is signed in; retrieve their contacts
      final userId = user.uid;

      try {
        final dbHelper = DatabaseHelper.instance;
        final existingContacts = await dbHelper.getContacts(userId);

        // Wait until contacts are retrieved
        await Future.delayed(const Duration(seconds: 1)); // Optional delay

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ContactsScreen(
              userId: userId,
              contacts: existingContacts,
            ),
          ),
        );
      } catch (e) {
        // Handle any errors (e.g., database issues)
        print("Error retrieving contacts: $e");
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    } else {
      // No user logged in; show splash for 2 seconds, then go to LoginScreen
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.jpg'),
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:toka_test/screens/contacts_screen.dart';
import 'package:toka_test/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is logged in, navigate to ContactsScreen
          return ContactsScreen(
            userId: snapshot.data, // Pass userId to the screen
          );
        } else {
          // User is not logged in, navigate to LoginScreen
          return LoginScreen();
        }
      },
    );
  }

  Future<String?> _checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid; // Return userId if logged in, else null
  }
}
 */
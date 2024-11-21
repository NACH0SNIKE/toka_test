import 'package:flutter/material.dart';
import 'package:toka_test/components/custom_text_field.dart';
import 'package:toka_test/components/long_button.dart';
import 'package:toka_test/screens/contacts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginScreen({super.key});

  Future<void> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Logged in as: ${userCredential.user?.email}');
      Navigator.pushNamed(
        context,
        ContactsScreen.id,
        arguments: {
          'userId': userCredential.user!.uid,
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        print('User not found. Creating new account...');
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushNamed(
          context,
          ContactsScreen.id,
          arguments: {
            'userId': userCredential.user!.uid,
          },
        );
        print('Account created for: ${userCredential.user?.email}');
      } else {
        print('Login error: ${e.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool showSpinner = false;
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreenAccent[700],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 80.0),
                child: Text(
                  'Toka Test',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      msg: 'Email Address',
                      icon: Icons.account_circle,
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomTextField(
                      msg: 'Password',
                      isPassword: true,
                      icon: Icons.account_circle,
                      controller: _passwordController,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    LongButton(
                      msg: 'Login',
                      buttonColor: Colors.white,
                      textColor: Colors.lightGreenAccent[700]!,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print('Valid email: ${_passwordController.text}');
                          /* loginWithEmail(
                            _emailController.text,
                            _passwordController.text,
                            context,
                          ); */
                          Navigator.pushNamed(
                            context,
                            ContactsScreen.id,
                          );
                        } else {
                          print('Invalid email');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

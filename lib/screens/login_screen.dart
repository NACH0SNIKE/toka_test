import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
      if (userCredential.user!.uid != null) {
        print('Logged in as: ${userCredential.user?.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ContactsScreen(
              userId: userCredential.user!.uid,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('-----------------------------------------------------');
      print(e.code);
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        print('User not found. Creating new account...');
        try {
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          if (userCredential.user?.uid != null) {
            print('Account created for: ${userCredential.user?.email}');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ContactsScreen(
                  userId: userCredential.user?.uid,
                ),
              ),
            );
          } else {
            Alert(
              context: context,
              type: AlertType.error,
              title: "Invalid Email",
              desc: "Please enter a valida email.",
              buttons: [
                DialogButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  width: 120,
                )
              ],
            ).show();
          }
        } on FirebaseAuthException catch (i) {
          Alert(
            context: context,
            type: AlertType.error,
            title: i.code == 'weak-password'
                ? 'Invalid Password'
                : 'Short Password',
            desc: i.code == 'weak-password'
                ? 'Something is wrong with the password. It could be that the password is wrong, too short or too weak.'
                : 'Password should be at least 6 characters.',
            buttons: [
              DialogButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
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
                          loginWithEmail(
                            _emailController.text,
                            _passwordController.text,
                            context,
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

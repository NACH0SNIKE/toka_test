import 'package:flutter/material.dart';
import 'package:toka_test/components/custom_text_field.dart';
import 'package:toka_test/components/long_button.dart';
import 'package:toka_test/screens/people_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    late String email;
    late String password;
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
                      onChange: (value) {
                        password = value;
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomTextField(
                      msg: 'Password',
                      isPassword: true,
                      icon: Icons.account_circle,
                      controller: _passwordController,
                      onChange: (value) {
                        password = value;
                      },
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PeopleListScreen();
                              },
                            ),
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

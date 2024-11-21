import 'dart:math';

import 'package:flutter/material.dart';
import 'package:toka_test/components/person_card.dart';
import 'package:toka_test/screens/details_screen.dart';

class PeopleListScreen extends StatelessWidget {
  static const id = 'PeopleListScreen';
  const PeopleListScreen({super.key});

  AssetImage getRandomPhoto() {
    if (true) {
      return AssetImage(
        'assets/images/${Random().nextInt(5) + 1}.jpg',
      );
    } else {
      return AssetImage(
        'assets/images/${Random().nextInt(5) + 6}.jpg',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent[700],
          centerTitle: true,
          title: const Text(
            'List of Contacts',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Sign Out') {
                  Navigator.pop(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Sign Out',
                    child: Text('Sign Out'),
                  ),
                ];
              },
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const DetailsScreen();
                      },
                    ),
                  );
                },
                child: PersonCard(
                  img: getRandomPhoto(),
                  name: 'John Doe',
                  email: 'realemail@email.com',
                  rating: 3,
                  address: 'Somewhere in Nowhere',
                ),
              );
            },
            itemCount: 5,
          ),
        ),
      ),
    );
  }
}

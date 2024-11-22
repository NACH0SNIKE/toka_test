import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toka_test/components/person_card.dart';
import 'package:toka_test/helpers/database_helper.dart';
import 'package:toka_test/models/contact.dart';
import 'package:http/http.dart' as http;
import 'package:toka_test/screens/contact_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toka_test/screens/login_screen.dart';

class ContactsScreen extends StatefulWidget {
  static const id = 'ContactsScreen';
  String? userId;
  List<Contact> contacts;

  ContactsScreen({
    super.key,
    required this.userId,
    List<Contact>? contacts,
  }) : contacts = contacts ?? [];

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.userId == null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      widget.userId = args['userId'];

      if (widget.userId != null) {
        fetchOrCreateContacts();
      } else {
        print('Error: userId is null');
      }
    }
  }

  Future<void> fetchOrCreateContacts() async {
    if (widget.userId == null) {
      print('Error: userId is null');
      return;
    }

    final dbHelper = DatabaseHelper.instance;

    try {
      final existingContacts = await dbHelper.getContacts(widget.userId!);

      if (existingContacts.isNotEmpty) {
        setState(() {
          widget.contacts = existingContacts;
        });
      } else {
        final newContacts =
            await Future.wait(List.generate(5, (_) => fetchRandomContact()));

        for (var contact in newContacts) {
          await dbHelper.saveContact(widget.userId!, contact);
        }

        setState(() {
          widget.contacts = newContacts;
        });
      }
    } catch (e) {
      print('Error fetching or creating contacts: $e');
    }
  }

  Future<Contact> fetchRandomContact() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final user = jsonData['results'][0];
      final rating = (List.generate(10, (_) => Random().nextDouble() * 10)
              .reduce((a, b) => a + b)) /
          10;

      return Contact(
        name: '${user['name']['first']} ${user['name']['last']}',
        gender: user['gender'],
        email: user['email'],
        rating: rating,
        address:
            '${user['location']['street']['number']} ${user['location']['street']['name']}',
        city: user['location']['city'],
        state: user['location']['state'],
        zipCode: user['location']['postcode'].toString(),
        phone: user['phone'],
      );
    } else {
      throw Exception('Failed to fetch data from API');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrCreateContacts();
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
              icon: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              onSelected: (value) async {
                if (value == 'logout') {
                  try {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, LoginScreen.id);
                  } catch (e) {
                    print("Error signing out: $e");
                  }
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'logout',
                  child: Text('Log Out'),
                ),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: widget.contacts.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: widget.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = widget.contacts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(
                              contact: contact,
                              photoNumber: contact.gender == 'male'
                                  ? index + 1
                                  : index + 6,
                            ),
                          ),
                        );
                      },
                      child: PersonCard(
                          img: contact.gender == 'male'
                              ? AssetImage('assets/images/${index + 1}.jpg')
                              : AssetImage('assets/images/${index + 6}.jpg'),
                          name: contact.name,
                          email: contact.email,
                          rating: contact.rating.toStringAsFixed(1),
                          address: contact.address),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

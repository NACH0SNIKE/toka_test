import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:toka_test/components/person_card.dart';
import 'package:toka_test/helpers/database_helper.dart';
import 'package:toka_test/models/contact.dart';
import 'package:http/http.dart' as http;
import 'package:toka_test/screens/contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  static const id = 'ContactsScreen';

  const ContactsScreen({
    super.key,
  });

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final String userId = '0';
  List<Contact> contacts = [];

  /* @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    userId = args['userId']!; // Get the userId passed as argument
    fetchOrCreateContacts();
  } */

  // Fetch contacts or create new ones
  Future<void> fetchOrCreateContacts() async {
    final dbHelper = DatabaseHelper.instance;
    final existingContacts = await dbHelper.getContacts(userId);

    // If contacts already exist for this user, load them
    if (existingContacts.isNotEmpty) {
      setState(() {
        contacts = existingContacts;
      });
    } else {
      // If no contacts exist, create 5 random contacts
      final newContacts =
          await Future.wait(List.generate(5, (_) => fetchRandomContact()));
      for (var contact in newContacts) {
        await dbHelper.saveContact(userId, contact); // Save each contact
      }
      setState(() {
        contacts = newContacts;
      });
    }
  }

  // Fetch a random contact from the API
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: contacts.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
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
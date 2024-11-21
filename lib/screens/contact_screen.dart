import 'package:flutter/material.dart';
import 'package:toka_test/components/info_with_detail.dart';
import 'package:toka_test/components/long_button.dart';
import 'package:toka_test/models/contact.dart';

class ContactScreen extends StatelessWidget {
  static const id = 'DetailScreen';
  Contact contact;
  int photoNumber;

  ContactScreen({
    super.key,
    required this.contact,
    required this.photoNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent[700],
          centerTitle: true,
          title: const Text(
            'Contact Detail',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage:
                        AssetImage('assets/images/${photoNumber}.jpg'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          contact.email,
                          style: TextStyle(
                            color: Colors.lightGreenAccent[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                              ),
                              TextSpan(
                                text: contact.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 50.0,
              ),
              Text(
                'Address',
                style: TextStyle(
                  color: Colors.lightGreenAccent[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              InfoWithDetail(
                info: 'Street: ',
                detail: contact.address,
              ),
              InfoWithDetail(
                info: 'City: ',
                detail: contact.city,
              ),
              InfoWithDetail(
                info: 'State: ',
                detail: contact.state,
              ),
              InfoWithDetail(
                info: 'Zip Code: ',
                detail: contact.zipCode,
              ),
              InfoWithDetail(
                info: 'Phone Number: ',
                detail: contact.phone,
              ),
              SizedBox(
                height: 30.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.lightGreenAccent[700],
                      ),
                    ),
                    TextSpan(
                      text: 'Location',
                      style: TextStyle(
                        color: Colors.lightGreenAccent[700],
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 50.0,
                ),
                child: Image.asset('assets/images/maps.png'),
              ),
              LongButton(
                msg: 'Contact',
                buttonColor: Colors.lightGreenAccent[700]!,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

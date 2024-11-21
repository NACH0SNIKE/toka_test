import 'package:flutter/material.dart';
import 'package:toka_test/components/info_with_detail.dart';
import 'package:toka_test/components/long_button.dart';

class DetailsScreen extends StatelessWidget {
  static const id = 'DetailScreen';
  const DetailsScreen({super.key});

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
                    backgroundImage: AssetImage('assets/images/1.jpg'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'realemail@email.com',
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
                              text: ' 4.9',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                detail: 'Some street',
              ),
              InfoWithDetail(
                info: 'City: ',
                detail: 'Saint Denis',
              ),
              InfoWithDetail(
                info: 'State: ',
                detail: 'Lemoyne',
              ),
              InfoWithDetail(
                info: 'Zip Code: ',
                detail: '42069',
              ),
              InfoWithDetail(
                info: 'Phone Number: ',
                detail: '(666) 420 6969',
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

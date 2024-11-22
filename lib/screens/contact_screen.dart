import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toka_test/components/info_with_detail.dart';
import 'package:toka_test/components/long_button.dart';
import 'package:toka_test/models/contact.dart';

class ContactScreen extends StatefulWidget {
  static const id = 'DetailScreen';
  Contact contact;
  int photoNumber;

  ContactScreen({
    super.key,
    required this.contact,
    required this.photoNumber,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late GoogleMapController mapController;
  late LatLng _center = LatLng(0.0, 0.0);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCoordinates(widget.contact.city);
  }

  Future<void> _getCoordinates(String city) async {
    try {
      List<Location> locations = await locationFromAddress(city);

      if (locations.isNotEmpty) {
        final location = locations.first;

        setState(() {
          _center = LatLng(location.latitude, location.longitude);

          _markers = {
            Marker(
              markerId: MarkerId('marker_1'),
              position: _center,
              infoWindow: InfoWindow(title: 'Location: $city'),
            ),
          };
        });

        mapController.animateCamera(
          CameraUpdate.newLatLng(_center),
        );
      }
    } catch (e) {
      print("Error getting coordinates: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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
                        AssetImage('assets/images/${widget.photoNumber}.jpg'),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contact.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.contact.email,
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
                                text: widget.contact.rating.toStringAsFixed(1),
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
                detail: widget.contact.address,
              ),
              InfoWithDetail(
                info: 'City: ',
                detail: widget.contact.city,
              ),
              InfoWithDetail(
                info: 'State: ',
                detail: widget.contact.state,
              ),
              InfoWithDetail(
                info: 'Zip Code: ',
                detail: widget.contact.zipCode,
              ),
              InfoWithDetail(
                info: 'Phone Number: ',
                detail: widget.contact.phone,
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
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 230.0,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 15.0,
                  ),
                  markers: _markers,
                ),
              ),
              const SizedBox(
                height: 40.0,
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

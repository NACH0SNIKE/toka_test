import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final AssetImage img;
  final String name;
  final String email;
  final double rating;
  final String address;

  PersonCard({
    super.key,
    required this.img,
    required this.name,
    required this.email,
    required this.rating,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: img,
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[600],
                          ),
                          Text(rating.toString()),
                        ],
                      )
                    ],
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.lightGreenAccent[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[400],
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

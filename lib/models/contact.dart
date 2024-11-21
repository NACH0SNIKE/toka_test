import 'dart:math';

class Contact {
  String name;
  String email;
  double rating;
  String address;
  String city;
  String state;
  String zipCode;
  String phone;

  Contact({
    required this.name,
    required this.email,
    required this.rating,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
  });

  double getRating() {
    double rating = 0;
    for (var i = 0; i < 10; i++) {
      rating += Random().nextInt(11);
    }
    return rating;
  }
}

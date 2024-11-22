import 'dart:math';

class Contact {
  String name;
  String gender;
  String email;
  double rating;
  String address;
  String city;
  String state;
  String zipCode;
  String phone;

  Contact({
    required this.name,
    required this.gender,
    required this.email,
    required this.rating,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'email': email,
      'rating': rating,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'phone': phone,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      gender: map['gender'],
      email: map['email'],
      rating: map['rating'],
      address: map['address'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zipCode'],
      phone: map['phone'],
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json) {
    double getRating() {
      double rating = 0;
      for (var i = 0; i < 10; i++) {
        rating += Random().nextInt(11);
      }
      return rating / 10;
    }

    return Contact(
      name:
          '${json['results'][0]['name']['first']} ${json['results'][0]['name']['last']}',
      gender: json['results'][0]['gender'],
      email: json['results'][0]['email'],
      rating: getRating(),
      address:
          '${json['results'][0]['location']['street']['number']} ${json['results'][0]['location']['street']['name']}',
      city: json['results'][0]['location']['city'],
      state: json['results'][0]['location']['state'],
      zipCode: json['results'][0]['location']['postcode'].toString(),
      phone: json['results'][0]['phone'],
    );
  }
}

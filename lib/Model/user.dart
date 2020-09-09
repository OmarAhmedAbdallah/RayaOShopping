import 'package:flutter/foundation.dart';

//this is becuase we need to add listner in a single product
class User extends ChangeNotifier {
  // final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  User({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phone,
    @required this.password,
  });

  static User userFromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['mobile'],
      password: '',
    );
  }
}

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    required this.name,
    required this.lastname,
    required this.age,
    required this.email,
    required this.contact,
  });

  String? id;
  String name;
  String lastname;
  int age;
  String email;
  int contact;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastname': lastname,
        'age': age,
        'contact': contact,
        'email': email,
      };
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        age: json["age"],
        contact: json["contact"],
        email: json["email"],
      );
}

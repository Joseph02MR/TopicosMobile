// To parse this JSON data, do
//
//     final Users = UsersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    //required this.token,
    required this.street,
    required this.zip,
    required this.city,
    required this.country,
    required this.id,
    required this.userId,
    required this.gender,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.username,
    required this.image,
    required this.isAdmin,
    required this.role
  });

  String street;
  String zip;
  String city;
  String country;
  String id;
  int userId;
  String gender;
  String name;
  String lastname;
  String email;
  String phone;
  String username;
  String image;
  bool isAdmin;
  String role;
  String token = "";

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    street: json["street"],
    zip: json["zip"],
    city: json["city"],
    country: json["country"],
    id: json["_id"],
    userId: json["id"],
    gender: json["gender"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    username: json["username"],
    image: json["image"],
    isAdmin: json["isAdmin"],
    role: json["role"],
    //token: json["token"]
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "zip": zip,
    "city": city,
    "country": country,
    "_id": id,
    "id": userId,
    "gender": gender,
    "name": name,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "username": username,
    "image": image,
    "isAdmin": isAdmin,
    "role": role,
    //"token":token
  };
}

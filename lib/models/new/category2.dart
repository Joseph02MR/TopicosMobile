// To parse this JSON data, do
//
//     final category2 = category2FromJson(jsonString);

import 'dart:convert';

List<Category2> category2FromJson(String str) => List<Category2>.from(json.decode(str).map((x) => Category2.fromJson(x)));

String category2ToJson(List<Category2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category2 {
  Category2({
    required this.id,
    required this.name,
    required this.imagen,
  });

  int id;
  String name;
  String imagen;

  factory Category2.fromJson(Map<String, dynamic> json) => Category2(
    id: json["id"],
    name: json["name"],
    imagen: json["imagen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imagen": imagen,
  };
}

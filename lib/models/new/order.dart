// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.id,
    required this.orderId,
    required this.date,
    required this.userId,
    required this.products,
    required this.status,
    required this.destAddress,
  });

  String id;
  int orderId;
  DateTime date;
  String userId;
  List<String> products;
  String status;
  String destAddress;
  List<String> prods_aux = [];

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    orderId: json["id"],
    date: DateTime.parse(json["date"]),
    userId: json["user_id"],
    products: List<String>.from(json["products"].map((x) => x)),
    status: json["status"],
    destAddress: json["dest_address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": orderId,
    "date": date.toIso8601String(),
    "user_id": userId,
    "products": List<dynamic>.from(products.map((x) => x)),
    "status": status,
    "dest_address": destAddress,
  };
}

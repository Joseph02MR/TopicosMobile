import 'dart:convert';

import 'package:ecommerce_int2/models/new/category2.dart';
import 'package:ecommerce_int2/models/new/order.dart';
import 'package:ecommerce_int2/models/new/product.dart';
import 'package:ecommerce_int2/models/new/users.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Category2>?> getCategories() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/category');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return category2FromJson(json);
    }
    return null;
  }

  Future<List<Users>?> getUsers() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return usersFromJson(json);
    }
    return null;
  }

  Future<Users?> getUserforLogin(String email, String password) async {
    Map<String, String> customHeaders = {"content-type": "application/json"};
    Map<String, String> bodyy = {"email": email, "password": password};

    var uri = Uri.parse(
        'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/login');
    var response =
        await http.post(uri, headers: customHeaders, body: jsonEncode(bodyy));
    //print(response.body);
    //print('kek');
    if (response.statusCode == 200) {
      print(response.body);

      var uri = Uri.parse(
          'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/getuser');
      response = await http.post(uri,
          headers: customHeaders, body: jsonEncode({'email': email}));

      if (response.statusCode == 200) {
        var json = response.body;
        List<Users> users_list = usersFromJson(json);
        return users_list[0];
      }
    }
    return null;
  }

  Future<bool> updateUser(Map<String, String> data, String oid) async {
    Map<String, String> customHeaders = {"content-type": "application/json"};
    var uri = Uri.parse(
        'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/'+ oid);
    var response =
        await http.put(uri, headers: customHeaders, body: jsonEncode(data));
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  Future<List<Order>?> getUserOrders(String oid) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/order/get/'+ oid);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return orderFromJson(json);
    }
    return null;
  }

  Future<List<String>?> getOrderProducts(List<String> prod_id) async {
    var client = http.Client();
    List<String> prods = [];
    try{
      prod_id.forEach((element) async {
        var uri = Uri.parse(
            'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/products/data/'+ element);
        var response = await client.get(uri);
        if (response.statusCode == 200) {
          var json = response.body;
          Product a = productFromJson(json);
          print(a.title);
          prods.add(a.title);
        }
      });
      prods.forEach((element) {print(element);});
    }catch(error){
      return null;
    }
    return prods;
  }


}

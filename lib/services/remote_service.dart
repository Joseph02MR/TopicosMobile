import 'dart:convert';

import 'package:ecommerce_int2/models/category2.dart';
import 'package:ecommerce_int2/models/users.dart';
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
    Map<String, String> customHeaders = {
    "content-type": "application/json"
    };
    Map<String, String> bodyy = {
      "email": email,
      "password":password
    };

    var uri = Uri.parse(
        'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/login');
    var response =
        await http.post(uri, headers:customHeaders, body: jsonEncode(bodyy));
    //print(response.body);
    //print('kek');
    if (response.statusCode == 200) {
      print(response.body);
      var aux = response.body;
      List<Users> users = usersFromJson(aux);

      var uri = Uri.parse(
          'https://joseph02mr-special-palm-tree-j9qq9gjrw7w3j5x-8000.preview.app.github.dev/api/v1/getuser');
      response = await http.post(uri, headers:customHeaders, body: jsonEncode({'email': email}));

      if (response.statusCode == 200) {
        var json = response.body;
        List<Users> users_list = usersFromJson(json);

        users_list[0].token = users[0].token;
        print(users_list[0].token);
        return users_list[0];
      }
    }
    return null;
  }
}

// ignore_for_file: deprecated_member_use, prefer_collection_literals

import 'package:http/http.dart' as http;
import "package:flutter/services.dart";

import 'User.dart';

class Service {
  static Future<List<User>> getUsers() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      if (response.statusCode == 200) {
        final List<User> user = userFromJson(response.body);
        return user;
      }else{
        return <User>[];
      }
    } catch (e) {
      return <User>[];
    }
  }
}

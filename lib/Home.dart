// ignore_for_file: await_only_futures, unused_label
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart' as rootBundle;
import "package:json_list_images/User.dart";
import "package:http/http.dart" as http;

import 'User.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: non_constant_identifier_names
  Future<List<User>> ReadData() async {
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: ReadData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: const Text("The data has an error"),
              );
            } else if (data.hasData) {
              var items = data.data as List<User>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      child: Image.network(items[index].url.toString(),fit: BoxFit.cover,),
                    )
                  );
                },
                itemCount: items.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

// ignore_for_file: await_only_futures

import "package:flutter/material.dart";
import "package:json_list_images/Service.dart";

import 'User.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<User>> getUser() async => Service.getUsers().then((user) {
        List<User> _users = user;
        return _users;
      });

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemBuilder: ((context, index) {
                User user = _users[index];
                return FittedBox(
                  child: Image.network(user.url),
                  fit: BoxFit.fill,
                );
              }),
            )));
  }
}

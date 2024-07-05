import 'package:flutter/material.dart';

import 'package:transaction_app/models/model.dart';

class ProfileScreen extends StatelessWidget {
  final AccountStatement statement;
  const ProfileScreen({super.key, required this.statement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        statement.account.profile.holders.holder.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        "${calculateAge(statement.account.profile.holders.holder.dob)} years old",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(
                  statement.account.profile.holders.holder.address,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.phone_android_outlined),
                title: Text(
                  statement.account.profile.holders.holder.mobile,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  statement.account.profile.holders.holder.email,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }

  int calculateAge(String dob) {
    DateTime now = DateTime.now();
    final DateTime date = DateTime.parse(dob);
    int age = now.year - date.year;
    if (now.month < date.month ||
        (now.month == date.month && now.day < date.day)) {
      age--;
    }
    return age;
  }
}

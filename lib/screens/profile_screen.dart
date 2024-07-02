import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FeatchDetailsBloc, FeatchDetailsState>(
        builder: (context, state) {
          return state is FeatchDetailsSuccessState
              ? Padding(
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
                                state.statement.account.profile.holders.holder
                                    .name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "${calculateAge(state.statement.account.profile.holders.holder.dob)} years old",
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
                          state
                              .statement.account.profile.holders.holder.address,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.phone_android_outlined),
                        title: Text(
                          state.statement.account.profile.holders.holder.mobile,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(
                          state.statement.account.profile.holders.holder.email,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              : const Center(
                  child: Text("data"),
                );
        },
      ),
    );
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

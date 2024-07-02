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
              ? Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                    ),
                    Text(
                      "Name : ${state.statement.account.profile.holders.holder.name}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Address : ${state.statement.account.profile.holders.holder.address}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Mobile : ${state.statement.account.profile.holders.holder.mobile}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Email : ${state.statement.account.profile.holders.holder.email}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "Date of Brith : ${state.statement.account.profile.holders.holder.dob}",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                )
              : const Center(
                  child: Text("data"),
                );
        },
      ),
    );
  }
}

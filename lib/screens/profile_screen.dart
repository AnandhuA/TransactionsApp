import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/data/bloc/featch_details/featch_details_bloc.dart';
import 'package:transaction_app/screens/splash_screen.dart';
import 'package:transaction_app/screens/widgets/confirmation_diloge.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<FeatchDetailsBloc>().add(FeatchAllDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
      ),
      body:
          Background(child: BlocBuilder<FeatchDetailsBloc, FeatchDetailsState>(
        builder: (context, state) {
          if (state is FeatchDetailsSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    subtitle: Text(
                      state.statement.account.profile.holders.holder.name,
                    ),
                    title: Text("Name"),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.date_range),
                    ),
                    title: Text("Date Of Birth"),
                    subtitle: Text(
                      state.statement.account.profile.holders.holder.dob,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.phone),
                    ),
                    title: Text("Mobile NO"),
                    subtitle: Text(
                      state.statement.account.profile.holders.holder.mobile,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.factory_outlined),
                    ),
                    title: Text("Address"),
                    subtitle: Text(
                      state.statement.account.profile.holders.holder.address,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.email),
                    ),
                    title: Text("E-Mail"),
                    subtitle: Text(
                      state.statement.account.profile.holders.holder.email,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.description_sharp),
                    ),
                    title: Text("Pan Card No"),
                    subtitle: Text(
                      state.statement.account.profile.holders.holder.pan,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.account_box),
                    ),
                    title: Text("AccountType"),
                    subtitle: Text(
                      state.statement.account.summary.type,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.account_balance_sharp),
                    ),
                    title: Text("Bank Branch"),
                    subtitle: Text(
                      state.statement.account.summary.branch,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.currency_rupee),
                    ),
                    title: Text("Current Balance"),
                    subtitle: Text(
                      state.statement.account.summary.currentBalance,
                    ),
                  ),
                  ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.logout),
                      ),
                      title: Text("Log Out"),
                      onTap: () {
                        confirmationDiloge(
                          context: context,
                          title: "Log Out",
                          content: "Are you sure you want to log out?",
                          confirmBtn: () async {
                            await FirebaseAuth.instance.signOut();
                            // Navigate to the login screen or handle post-logout logic here
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SplashScreen(),
                              ),
                              (route) => false,
                            );
                          },
                        );
                      })
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("data"),
            );
          }
        },
      )),
    );
  }
}

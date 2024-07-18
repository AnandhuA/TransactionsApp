// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:transaction_app/core/const_size.dart';
// import 'package:transaction_app/models/model.dart';

// class CardWidget extends StatelessWidget {
//   const CardWidget({
//     super.key,
//     required this.formattedBalance,
//     required this.statement,
//   });

//   final String formattedBalance;
//   final AccountStatement statement;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//         color: Colors.white.withOpacity(0.1),
//       ),
//       child: ClipRRect(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.2),
//                 width: 1.5,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Current Balance",
//                           style: TextStyle(fontSize: 17),
//                         ),
//                         Text(
//                           "₹ $formattedBalance",
//                           style: const TextStyle(fontSize: 30),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 height10,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       "Type: ${statement.account.summary.type}",
//                     ),
//                     Text(
//                       "Status: ${statement.account.summary.status}",
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/models/model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.formattedBalance,
    required this.statement,
  });

  final String formattedBalance;
  final AccountStatement statement;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.white.withOpacity(0.1),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: ExpansionTile(
              // tilePadding: const EdgeInsets.all(10),
              title: const Text(
                'Current Balance',
                style: TextStyle(fontSize: 17),
              ),
              subtitle: Text(
                '₹ $formattedBalance',
                style: const TextStyle(fontSize: 30),
              ),
              childrenPadding: const EdgeInsets.all(10),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Type: ${statement.account.summary.type}',
                      style: const TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Status: ${statement.account.summary.status}',
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
                height25,
                _CustomWidget(
                    title: 'Account Number', content: statement.maskedAccount),
                height10,
                _CustomWidget(
                    title: 'Email',
                    content: statement.account.profile.holders.holder.email),
                height10,
                _CustomWidget(
                    title: 'Phone Number',
                    content: statement.account.profile.holders.holder.mobile),
                height10,
                _CustomWidget(
                    title: 'Pan Number',
                    content: statement.account.profile.holders.holder.pan),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomWidget extends StatelessWidget {
  final String title;
  final String content;

  const _CustomWidget({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

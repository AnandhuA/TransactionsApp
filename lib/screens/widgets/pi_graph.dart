import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';

class PiGraph extends StatelessWidget {
  const PiGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PieChart(
        PieChartData(
          titleSunbeamLayout: false,
          sections: [
            PieChartSectionData(
              color: primaryColor,
              value: 20,
              title: "Savinga",
              radius: 80,
            ),
            PieChartSectionData(
              color: Colors.purple,
              value: 30,
              title: "petrol",
              radius: 70,
            ),
            PieChartSectionData(
              color: Colors.green.shade300,
              value: 80,
              title: "salary",
              radius: 100,
            ),
            PieChartSectionData(
              color: Colors.teal,
              value: 10,
              title: "Others",
              radius: 90,
            ),
          ],
        ),
        swapAnimationDuration: const Duration(seconds: 2), // Optional
        swapAnimationCurve: Curves.easeInOutCubicEmphasized, // Optional
      ),
    );
  }
}

class PigraphDetailsWidget extends StatelessWidget {
  const PigraphDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              categoreyIteam(
                  color: Colors.pinkAccent.shade100,
                  title: "Saveings",
                  value: "50%"),
              categoreyIteam(
                  color: Colors.pinkAccent.shade100,
                  title: "Saveings",
                  value: "50%"),
              categoreyIteam(
                  color: Colors.pinkAccent.shade100,
                  title: "Saveings",
                  value: "50%")
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              categoreyIteam(
                  color: Colors.pinkAccent.shade100,
                  title: "Saveings",
                  value: "50%"),
              categoreyIteam(
                  color: Colors.pinkAccent.shade100,
                  title: "Saveings",
                  value: "50%"),
              categoreyIteam(
                  color: Colors.pinkAccent.shade100,
                  title: "Saveings",
                  value: "50%")
            ],
          )
        ],
      ),
    );
  }

  Row categoreyIteam(
      {required String title, required Color color, required String value}) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
        ),
        width10,
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        width10,
        Text(value, style: const TextStyle(fontSize: 18))
      ],
    );
  }
}

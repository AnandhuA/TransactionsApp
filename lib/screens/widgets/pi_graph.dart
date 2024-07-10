import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/colors.dart';

class PiGraph extends StatelessWidget {
  final double saveings;
  final double electricity;
  final double rent;
  final double salary;
  final double others;
  final double petrol;

  const PiGraph({
    super.key,
    required this.saveings,
    required this.electricity,
    required this.rent,
    required this.salary,
    required this.others,
    required this.petrol,
  });

  @override
  Widget build(BuildContext context) {
    final total = saveings + electricity + rent + salary + others + petrol;
    final maxValue = [saveings, electricity, rent, salary, others, petrol]
        .reduce((a, b) => a > b ? a : b);
    const minRadius = 70.0;
    const maxRadius = 100.0;

    double calculateRadius(double value) {
      return minRadius + (value / maxValue) * (maxRadius - minRadius);
    }

    final sections = [
      PieChartSectionData(
          gradient: LinearGradient(
            colors: [Colors.green.shade100, saveingsColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          showTitle: false,
          titleStyle: const TextStyle(color: Colors.black),
          color: saveingsColor,
          value: saveings / total * 100,
          title: '${(saveings / total * 100).toStringAsFixed(1)}%',
          radius: calculateRadius(saveings)),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, electricityColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        showTitle: false,
        titleStyle: const TextStyle(color: Colors.black),
        color: electricityColor,
        value: electricity / total * 100,
        title: '${(electricity / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(electricity),
      ),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, rentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        showTitle: false,
        titleStyle: const TextStyle(color: Colors.black),
        color: rentColor,
        value: rent / total * 100,
        title: '${(rent / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(rent),
      ),
      // PieChartSectionData(
      //   color: Colors.tealAccent.shade100,
      //   value: salary / total * 100,
      //   title: '${(salary / total * 100).toStringAsFixed(1)}%',
      //   radius: calculateRadius(salary),
      // ),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, petrolColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        showTitle: false,
        titleStyle: const TextStyle(color: Colors.black),
        color: petrolColor,
        value: petrol / total * 100,
        title: '${(petrol / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(petrol),
      ),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [Colors.green.shade100, otherColor],
          begin: Alignment.bottomRight,
          end: Alignment.topCenter,
        ),
        titleStyle: const TextStyle(color: Colors.black, fontSize: 10),
        showTitle: false,
        color: otherColor,
        value: others / total * 100,
        title: '${(others / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(others),
      ),
    ];

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: PieChart(
        PieChartData(
          sections: sections,
          // titlePositionPercentageOffset: 0.55,
        ),
        swapAnimationDuration: const Duration(seconds: 2), // Optional
        swapAnimationCurve: Curves.easeInOutCubicEmphasized, // Optional
      ),
    );
  }
}

class PigraphDetailsWidget extends StatelessWidget {
  final double saveings;
  final double electricity;
  final double rent;
  final double salary;
  final double others;
  final double petrol;

  const PigraphDetailsWidget({
    super.key,
    required this.saveings,
    required this.electricity,
    required this.rent,
    required this.salary,
    required this.others,
    required this.petrol,
  });

  @override
  Widget build(BuildContext context) {
    final total = saveings + electricity + rent + salary + others + petrol;

    final saveingsPercentage =
        '${(saveings / total * 100).toStringAsFixed(1)}%';
    final electricityPercentage =
        '${(electricity / total * 100).toStringAsFixed(1)}%';
    final rentPercentage = '${(rent / total * 100).toStringAsFixed(1)}%';
    final salaryPercentage = '${(salary / total * 100).toStringAsFixed(1)}%';
    final othersPercentage = '${(others / total * 100).toStringAsFixed(1)}%';
    final petrolPercentage = '${(petrol / total * 100).toStringAsFixed(1)}%';

    return Column(
      children: [
        PiGraph(
          saveings: saveings,
          electricity: electricity,
          rent: rent,
          salary: salary,
          others: others,
          petrol: petrol,
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categoryItem(
                      color: saveingsColor,
                      title: "Savings",
                      value: saveingsPercentage),
                  categoryItem(
                      color: electricityColor,
                      title: "Electricity",
                      value: electricityPercentage),
                  categoryItem(
                      color: rentColor, title: "Rent", value: rentPercentage)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // categoryItem(
                  //     color: Colors.tealAccent.shade100,
                  //     title: "Salary",
                  //     value: salaryPercentage),
                  categoryItem(
                      color: petrolColor,
                      title: "Petrol",
                      value: petrolPercentage),
                  categoryItem(
                      color: otherColor,
                      title: "Others",
                      value: othersPercentage),
                  categoryItem(
                    color: Colors.transparent,
                    title: "",
                    value: "",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row categoryItem({
    required String title,
    required Color color,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5)),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Text(value, style: const TextStyle(fontSize: 18))
      ],
    );
  }
}

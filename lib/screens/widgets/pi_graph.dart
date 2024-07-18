import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:transaction_app/core/colors.dart';
import 'package:transaction_app/core/const_size.dart';

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
        height30,
        height20,
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

class PiGraph extends StatefulWidget {
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
  PiGraphState createState() => PiGraphState();
}

class PiGraphState extends State<PiGraph> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final total = widget.saveings +
        widget.electricity +
        widget.rent +
        widget.salary +
        widget.others +
        widget.petrol;

    if (total == 0.0) {
      return Center(
        child: Column(
          children: [
            Lottie.asset("assets/no transation.json", width: 150),
            const Text("No Transaction Found")
          ],
        ),
      );
    }
    final maxValue = [
      widget.saveings,
      widget.electricity,
      widget.rent,
      widget.salary,
      widget.others,
      widget.petrol
    ].reduce((a, b) => a > b ? a : b);
    const minRadius = 80.0;
    const maxRadius = 100.0;

    double calculateRadius(double value) {
      return minRadius + (value / maxValue) * (maxRadius - minRadius);
    }

    final sections = [
      PieChartSectionData(
          gradient: LinearGradient(
            colors: [saveingsColor100, saveingsColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          showTitle: false,
          color: saveingsColor,
          value: widget.saveings / total * 100,
          title: '${(widget.saveings / total * 100).toStringAsFixed(1)}%',
          radius: calculateRadius(widget.saveings)),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [electricityColor100, electricityColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        showTitle: false,
        color: electricityColor,
        value: widget.electricity / total * 100,
        title: '${(widget.electricity / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(widget.electricity),
      ),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [rentColor100, rentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        showTitle: false,
        color: rentColor,
        value: widget.rent / total * 100,
        title: '${(widget.rent / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(widget.rent),
      ),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [petrolColor100, petrolColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        showTitle: false,
        color: petrolColor,
        value: widget.petrol / total * 100,
        title: '${(widget.petrol / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(widget.petrol),
      ),
      PieChartSectionData(
        gradient: LinearGradient(
          colors: [otherColor100, otherColor],
          begin: Alignment.bottomRight,
          end: Alignment.topCenter,
        ),
        showTitle: false,
        color: otherColor,
        value: widget.others / 2 / total * 100,
        title: '${(widget.others / total * 100).toStringAsFixed(1)}%',
        radius: calculateRadius(widget.others),
      )
    ];

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              borderData: FlBorderData(show: true, border: Border.all()),
              sections: sections,
              pieTouchData: PieTouchData(
                enabled: true,
                touchCallback: (touchEvent, pieTouchResponse) {
                  setState(() {
                    if (pieTouchResponse != null &&
                        pieTouchResponse.touchedSection != null) {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                },
              ),
              centerSpaceRadius: 60,
            ),
            swapAnimationDuration: const Duration(seconds: 5),
            swapAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ),
          Center(
            child: touchedIndex != -1
                ? Text(
                    sections[touchedIndex].title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    'Total\n ₹${total.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

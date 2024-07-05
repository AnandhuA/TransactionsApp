import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  final List<PieChartSectionData> dailyPieChartSections;
  final List<PieChartSectionData> monthlyPieChartSections;
  final List<PieChartSectionData> yearlyPieChartSections;
  const ChartWidget({
    super.key,
    required this.dailyPieChartSections,
    required this.monthlyPieChartSections,
    required this.yearlyPieChartSections,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 260,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: [
          _buildPieChart(dailyPieChartSections, 'Daily'),
          _buildPieChart(monthlyPieChartSections, 'Monthly'),
          _buildPieChart(yearlyPieChartSections, 'Yearly'),
        ].map((widget) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: widget,
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPieChart(
    List<PieChartSectionData> sections,
    String title,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.cyan.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title Transactions',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 250,
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 50,
                  sectionsSpace: 3,
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/core/background.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/models/model.dart';
import 'package:transaction_app/network/featch_data.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  AnalyticsScreenState createState() => AnalyticsScreenState();
}

class AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedMonth = 'January';
  String selectedYear = '2024';

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
  ];

  List<BarChartGroupData> barGroups = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final AccountStatement? response = await FeatchData.featchData();

    if (response != null) {
      List<Transaction> allTransactions =
          response.account.transactions.transactionList;

      // Filter transactions based on the selected year and month
      int selectedMonthIndex = months.indexOf(selectedMonth) + 1;
      final List<Transaction> transactionsWithDate =
          allTransactions.where((transaction) {
        DateTime transactionDate = DateTime.parse(transaction.valueDate);
        return transactionDate.year == int.parse(selectedYear) &&
            transactionDate.month == selectedMonthIndex;
      }).toList();

      // Calculate totals for debit, credit, savings, and policy transactions
      List<Transaction> creditTransactions = transactionsWithDate
          .where((transaction) => transaction.type == 'CREDIT')
          .toList();
      List<Transaction> debitTransactions = transactionsWithDate
          .where((transaction) => transaction.type == 'DEBIT')
          .toList();

      double totalDebitAmount = debitTransactions.fold(
          0.0, (sum, transaction) => sum + double.parse(transaction.amount));
      double totalCreditAmount = creditTransactions.fold(
          0.0, (sum, transaction) => sum + double.parse(transaction.amount));

      List<Transaction> savingsTransactions = transactionsWithDate
          .where((transaction) => transaction.narration
              .toLowerCase()
              .contains("MutualFunds".toLowerCase()))
          .toList();
      double totalSavingsAmount = savingsTransactions.fold(
          0.0, (sum, transaction) => sum + double.parse(transaction.amount));

      List<Transaction> policyTransactions = transactionsWithDate
          .where((transaction) => transaction.narration
              .toLowerCase()
              .contains("POLICYBAZAAR".toLowerCase()))
          .toList();
      double totalPolicyAmount = policyTransactions.fold(
          0.0, (sum, transaction) => sum + double.parse(transaction.amount));

      // Create bar groups from the calculated totals
      setState(() {
        barGroups = [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                  toY: totalDebitAmount,
                  width: 30,
                  color: Colors.cyan.shade300,
                  borderRadius: BorderRadius.zero)
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                  toY: totalCreditAmount,
                  width: 30,
                  color: Colors.orange.shade300,
                  borderRadius: BorderRadius.zero)
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                  toY: totalSavingsAmount,
                  width: 30,
                  color: Colors.purple.shade300,
                  borderRadius: BorderRadius.zero)
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                  toY: totalPolicyAmount,
                  width: 30,
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.zero)
            ],
          ),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Analytics'),
        actions: [
          DropdownButton<String>(
            value: selectedYear,
            items: years.map((String year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(year),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedYear = newValue!;
                fetchData(); // Update the BarChart based on the selected year
              });
            },
          ),
          DropdownButton<String>(
            value: selectedMonth,
            items: months.map((String month) {
              return DropdownMenuItem<String>(
                value: month,
                child: Text(month),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedMonth = newValue!;
                fetchData(); // Update the BarChart based on the selected month
              });
            },
          ),
        ],
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text("Debit");
                              case 1:
                                return const Text("Credit");
                              case 2:
                                return const Text("Investment");
                              case 3:
                                return const Text("Savings");
                              default:
                                return const Text("");
                            }
                          },
                        ),
                      ),
                    ),
                    barGroups: barGroups,
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                ),
              ),
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
                            color: Colors.cyan.shade300,
                            title: "Debit",
                            value: ""),
                        categoryItem(
                            color: Colors.orange.shade300,
                            title: "Credit",
                            value: ""),
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
                            color: Colors.purple.shade300,
                            title: "Investment",
                            value: ""),
                        categoryItem(
                            color: Colors.green.shade300,
                            title: "Savings",
                            value: ""),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

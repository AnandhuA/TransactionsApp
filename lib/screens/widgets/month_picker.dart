import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> showMonthPicker(
    BuildContext context, Function(DateTime) onMonthSelected) async {
  final selectedDate = await showModalBottomSheet<DateTime>(
    context: context,
    builder: (context) {
      return MonthPickerDialog(onMonthSelected: onMonthSelected);
    },
  );
}

class MonthPickerDialog extends StatefulWidget {
  final Function(DateTime) onMonthSelected;

  const MonthPickerDialog({
    required this.onMonthSelected,
    super.key,
  });

  @override
  MonthPickerDialogState createState() => MonthPickerDialogState();
}

class MonthPickerDialogState extends State<MonthPickerDialog> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: YearMonthPicker(
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                setState(() {
                  selectedDate = dateTime;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onMonthSelected(selectedDate);
              Navigator.pop(context, selectedDate);
            },
            child: const Text('Select Month'),
          ),
        ],
      ),
    );
  }
}

class YearMonthPicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onChanged;

  const YearMonthPicker({
    required this.selectedDate,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: YearPicker(
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            selectedDate: selectedDate,
            onChanged: (DateTime dateTime) {
              onChanged(DateTime(dateTime.year, selectedDate.month));
            },
          ),
        ),
        Expanded(
          child: MonthPicker(
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            selectedDate: selectedDate,
            onChanged: (DateTime dateTime) {
              onChanged(DateTime(selectedDate.year, dateTime.month));
            },
          ),
        ),
      ],
    );
  }
}

class MonthPicker extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onChanged;

  const MonthPicker({
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final months = List.generate(12, (index) => DateTime(0, index + 1));
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: months.length,
      itemBuilder: (context, index) {
        final month = months[index];
        return InkWell(
          onTap: () => onChanged(DateTime(selectedDate.year, month.month)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: month.month == selectedDate.month
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                DateFormat.MMMM().format(month),
                style: TextStyle(
                  color: month.month == selectedDate.month
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

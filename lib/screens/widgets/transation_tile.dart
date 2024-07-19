import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transaction_app/core/const_size.dart';
import 'package:transaction_app/models/model.dart';

class ExpandableListTile extends StatefulWidget {
  final Transaction transation;

  const ExpandableListTile({
    super.key,
    required this.transation,
  });

  @override
  ExpandableListTileState createState() => ExpandableListTileState();
}

class ExpandableListTileState extends State<ExpandableListTile> {
  bool _isExpanded = false;
  late String formattedDateTime;
  @override
  void initState() {
    DateTime dateTime = DateTime.parse(widget.transation.transactionTimestamp);
    formattedDateTime = DateFormat.yMMMd().format(dateTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          border: Border.all(color: const Color.fromARGB(179, 165, 165, 165)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: widget.transation.type == "DEBIT"
                        ? const Icon(Icons.call_received)
                        : const Icon(Icons.call_made),
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.transation.narration,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Column(
                  children: [
                    widget.transation.type == "CREDIT"
                        ? Text(
                            widget.transation.amount,
                            style: const TextStyle(color: Colors.green),
                          )
                        : Text(
                            "-${widget.transation.amount}",
                            style: const TextStyle(color: Colors.red),
                          ),
                    height10,
                    Text(formattedDateTime),
                  ],
                )
              ],
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bank Narration",
                      style: TextStyle(color: Colors.grey),
                    ),
                    height5,
                    Text(
                      widget.transation.narration,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    height10,
                    const Text(
                      "Mode of Payment",
                      style: TextStyle(color: Colors.grey),
                    ),
                    height5,
                    Text(
                      widget.transation.mode,
                      style: const TextStyle(fontSize: 16),
                    ),
                    height10,
                    const Text(
                      "Transaction Time",
                      style: TextStyle(color: Colors.grey),
                    ),
                    height5,
                    Text(
                      DateFormat.jm().format(DateTime.parse(
                          widget.transation.transactionTimestamp)),
                      style: const TextStyle(fontSize: 16),
                    ),
                    height10,
                    Center(
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "View Transaction",
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

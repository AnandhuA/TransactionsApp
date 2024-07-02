import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:transaction_app/models/model.dart';

class FeatchData {
  static Future<AccountStatement?> featchData() async {
    try {
      String jsonData = await rootBundle
          .loadString('assets/1_fip_processed_da101fb0_periodic.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonData);

      if (jsonMap.containsKey('BARB0KIMXXX')) {
        List<dynamic> accountData = jsonMap['BARB0KIMXXX'];

        if (accountData.isNotEmpty) {
          Map<String, dynamic> accountInfo = accountData.first;

          AccountStatement statements = AccountStatement.fromJson(accountInfo);

          return statements;
        } else {
          print('No data found.');
          return null;
        }
      } else {
        print('Key "BARB0KIMXXX" not found in JSON data.');
        return null;
      }
    } catch (e) {
      print('Error reading or parsing JSON: $e');
      return null;
    }
  }
}

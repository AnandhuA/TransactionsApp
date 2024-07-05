import 'package:flutter/material.dart';
import 'package:transaction_app/core/colors.dart';

final elevatedButtonStyle = ButtonStyle(
  minimumSize: const WidgetStatePropertyAll(
    Size(double.infinity, 60),
  ),
  backgroundColor: const WidgetStatePropertyAll(
    primaryColor,
  ),
  textStyle: const WidgetStatePropertyAll(
    TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
  ),
  foregroundColor: const WidgetStatePropertyAll(
    whiteColor,
  ),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        20,
      ),
    ),
  ),
);


final textFieldStyle =  InputDecorationTheme(
  contentPadding: const EdgeInsets.all(20),
  border: const OutlineInputBorder(
    borderSide:  BorderSide(color: boderColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: boderColor),
    borderRadius: BorderRadius.circular(20),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: errorColor),
  ),
  fillColor: bacgroundColor,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: primaryColor),
    borderRadius: BorderRadius.circular(20),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: primaryColor),
  ),
  hintStyle: const TextStyle(
    
    fontSize: 15,
  ),
);

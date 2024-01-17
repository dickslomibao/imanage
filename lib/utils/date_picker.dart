import 'package:flutter/material.dart';

Future<DateTime?> showDateBox(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 7320)),
  );
}

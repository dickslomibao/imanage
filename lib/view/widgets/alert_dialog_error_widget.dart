import 'package:flutter/material.dart';

class AlertErrorDialog extends StatelessWidget {
  const AlertErrorDialog({super.key, required this.error});
  final String? error;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              error ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

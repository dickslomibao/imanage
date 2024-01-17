import 'package:flutter/material.dart';
import 'package:imanage/view/widgets/alert_dialog_error_widget.dart';

void showError(BuildContext ctx, String? error) {
  showDialog(
    context: ctx,
    builder: (context) {
      return AlertErrorDialog(
        error: error,
      );
    },
  );
}

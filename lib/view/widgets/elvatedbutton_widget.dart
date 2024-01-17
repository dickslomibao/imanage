import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btnBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: buttonTxt(label),
    );
  }
}

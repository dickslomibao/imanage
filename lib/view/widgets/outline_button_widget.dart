import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';

class OutLineButtonWidget extends StatelessWidget {
  const OutLineButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: btnBgColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: buttonTxt(label),
    );
  }
}

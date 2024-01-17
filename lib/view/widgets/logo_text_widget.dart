import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';

class LogoTextWidget extends StatelessWidget {
  const LogoTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'iManage',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
        color: txtColor,
      ),
    );
  }
}

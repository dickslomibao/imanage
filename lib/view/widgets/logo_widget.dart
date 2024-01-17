import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: btnBgColor,
        ),
      ),
      width: 40,
      height: 35,
      child: const Center(
        child: Text(
          'IM',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: txtColor,
          ),
        ),
      ),
    );
  }
}

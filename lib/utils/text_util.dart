import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';

Widget buttonTxt(String label, {Color color = txtColor}) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
Widget txtHeader(String label, {TextAlign align = TextAlign.center}) => Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: txtColor,
      ),
    );
Widget txtSubHeader(String label, {TextAlign align = TextAlign.center}) => Text(
      label,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: txtColor,
      ),
    );
Widget txtLabel(String label, {TextAlign align = TextAlign.center}) => Text(
      label,
      textAlign: align,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: txtColor,
      ),
    );

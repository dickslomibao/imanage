import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';

class DateFieldWidget extends StatelessWidget {
  const DateFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
  });
  final String label;
  final TextEditingController controller;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: txtColor,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: inputFieldBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            readOnly: true,
            onTap: () {
              onTap();
            },
            controller: controller,
            style: const TextStyle(
              color: txtColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.calendar_month),
              suffixIconColor: txtColor,
              contentPadding: EdgeInsets.all(20),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

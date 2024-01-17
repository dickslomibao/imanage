import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.toggle = false,
    this.readOnly = false,
    this.color = inputFieldBgColor,
    this.onPassword,
  });
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool readOnly;
  final Color color;
  final dynamic onPassword;
  final bool toggle;
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
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            readOnly: readOnly,
            onTap: () {},
            controller: controller,
            obscureText: toggle,
            style: const TextStyle(
              color: txtColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              suffixIcon: Visibility(
                visible: isPassword,
                child: IconButton(
                    onPressed: () {
                      onPassword();
                    },
                    icon: Icon(toggle
                        ? Icons.visibility_off_outlined
                        : Icons.visibility)),
              ),
              suffixIconColor: txtColor,
              contentPadding: const EdgeInsets.all(20),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:imanage/utils/text_util.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width / 4,
          height: 2,
          color: const Color.fromRGBO(255, 255, 255, .5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: txtLabel('OR'),
        ),
        Container(
          width: width / 4,
          height: 2,
          color: const Color.fromRGBO(255, 255, 255, .5),
        ),
      ],
    );
  }
}

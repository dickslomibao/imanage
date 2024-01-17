import 'package:flutter/material.dart';
import 'package:imanage/utils/palette.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Center(
        child: SingleChildScrollView(
          child: CircularProgressIndicator(
            color: btnBgColor,
          ),
        ),
      ),
    );
  }
}

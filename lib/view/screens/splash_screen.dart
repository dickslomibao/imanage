import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imanage/services/hive.dart';

import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/view/widgets/elvatedbutton_widget.dart';
import 'package:imanage/view/widgets/logo_text_widget.dart';
import 'package:imanage/view/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        LogoWidget(),
                        LogoTextWidget(),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      txtHeader('Welcome to iManage'),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Let's make your to-do list a thing of the past",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: txtColor,
                        ),
                      ),
                      Image.asset(
                        'assets/victor/home2.png',
                      ),
                      txtLabel("Developed By:"),
                      const SizedBox(
                        height: 5,
                      ),
                      txtLabel("Dick Soriano Lomibao"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButtonWidget(
                      onPressed: () async {
                        await hiveServices.setSplash();
                        if (context.mounted) {
                          context.goNamed('login');
                        }
                      },
                      label: 'Get Started',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

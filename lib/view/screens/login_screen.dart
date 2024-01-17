import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imanage/services/firebase_authetication.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/validator/validator_alert_dialog.dart';
import 'package:imanage/view/widgets/alert_dialog_loader.dart';
import 'package:imanage/view/widgets/elvatedbutton_widget.dart';
import 'package:imanage/view/widgets/logo_text_widget.dart';
import 'package:imanage/view/widgets/logo_widget.dart';
import 'package:imanage/view/widgets/or_divider_widget.dart';
import 'package:imanage/view/widgets/text_field_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imanage/view_model/login_vmode.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      LogoWidget(),
                      LogoTextWidget(),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/victor/continue1.png',
                  height: 250,
                ),
                const SizedBox(
                  height: 20,
                ),
                txtHeader('Connect with iManage'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 12,
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                        color: btnBgColor,
                      ),
                    ),
                    onPressed: () async {
                      await authServices.signInWithGoogle();
                      if (context.mounted) {
                        context.goNamed('splash');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.google,
                          size: 21,
                          color: txtColor,
                        ),
                        buttonTxt('Continue with Gmail'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const OrDividerWidget(),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: usernameController,
                        label: 'Username:',
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldWidget(
                        toggle: hidePass,
                        onPassword: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        controller: passwordController,
                        label: 'Password:',
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                txtLabel('Forgot Password?'),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.00,
                    horizontal: 14,
                  ),
                  child: ElevatedButtonWidget(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => const LoaderWidget(),
                      );
                      String status = await loginViewModel.login(
                          usernameController.text.trim(),
                          passwordController.text.trim());
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        if (status != 'success') {
                          showError(context, status);
                        } else {
                          context.goNamed('splash');
                        }
                      }
                    },
                    label: 'Login',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.goNamed("register");
                  },
                  child: txtLabel(
                    "Don't have account yet? Sign up",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

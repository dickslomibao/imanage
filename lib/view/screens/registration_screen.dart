import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imanage/models/user_model.dart';
import 'package:imanage/services/firebase_authetication.dart';
import 'package:imanage/services/firebase_user_firestore.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/validator/validate_form.dart';
import 'package:imanage/validator/validator_alert_dialog.dart';
import 'package:imanage/view/widgets/alert_dialog_loader.dart';
import 'package:imanage/view/widgets/elvatedbutton_widget.dart';
import 'package:imanage/view/widgets/logo_text_widget.dart';
import 'package:imanage/view/widgets/logo_widget.dart';
import 'package:imanage/view/widgets/text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController firstnameController = TextEditingController();

  final TextEditingController lastnameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController comfirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidePass = true;
  bool hideComfirmPass = true;
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
                  'assets/victor/home2.png',
                  height: 250,
                ),
                txtHeader('Create an account'),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: firstnameController,
                          label: 'Firstname:',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFieldWidget(
                          controller: lastnameController,
                          label: 'Lastname:',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFieldWidget(
                          controller: emailController,
                          label: 'Email:',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
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
                        const SizedBox(
                          height: 12,
                        ),
                        TextFieldWidget(
                          toggle: hideComfirmPass,
                          onPassword: () {
                            setState(() {
                              hideComfirmPass = !hideComfirmPass;
                            });
                          },
                          controller: comfirmPasswordController,
                          label: 'Comfirm password:',
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.00,
                    horizontal: 14,
                  ),
                  child: ElevatedButtonWidget(
                    onPressed: () async {
                      String? firstName =
                          validate.validateFirstname(firstnameController.text);
                      String? lastName =
                          validate.validateLastname(lastnameController.text);
                      String? userName =
                          validate.validateUsername(usernameController.text);
                      String? email =
                          validate.validateEmail(emailController.text);
                      String? password =
                          validate.validatePassword(passwordController.text);
                      String? comfirmPassword =
                          validate.validateComfirmPassword(
                        comfirmPasswordController.text,
                        passwordController.text,
                      );
                      if (firstName != null) {
                        showError(context, firstName);
                        return;
                      }
                      if (lastName != null) {
                        showError(context, lastName);
                        return;
                      }

                      if (email != null) {
                        showError(context, email);
                        return;
                      }
                      if (userName != null) {
                        showError(context, userName);
                        return;
                      }

                      if (password != null) {
                        showError(context, password);
                        return;
                      }
                      if (comfirmPassword != null) {
                        showError(context, comfirmPassword);
                        return;
                      }
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => const LoaderWidget(),
                      );
                      bool isUsed = await userFirestore
                          .usernameIsUsed(usernameController.text.trim());
                      if (!isUsed) {
                        String status =
                            await authServices.createEmailAndPassword(
                          UserModel(
                            email: emailController.text.trim(),
                            firstname: firstnameController.text.trim(),
                            lastname: lastnameController.text.trim(),
                            password: passwordController.text.trim(),
                            username: usernameController.text.trim(),
                          ),
                        );
                        if (context.mounted) {
                          if (status != 'success') {
                            Navigator.of(context).pop();
                            showError(context, status);
                            return;
                          }
                          if (context.mounted) {
                            context.goNamed('splash');
                          }
                        }
                        return;
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        showError(context, 'Username is already used.');
                      }
                    },
                    label: 'Sign up',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.goNamed('splash');
                  },
                  child: txtLabel(
                    "Already have an account? Login",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

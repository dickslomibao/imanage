import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import 'package:imanage/view/widgets/outline_button_widget.dart';
import 'package:imanage/view/widgets/text_field_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  bool readOnly = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LogoWidget(),
                  const LogoTextWidget(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          context.pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: txtColor,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: userFirestore.getUserDataForUpdate(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: btnBgColor,
                        ),
                      );
                    }
                    final data = snapshot.data!.data();
                    firstnameController.text = data!['firstname'];
                    lastnameController.text = data['lastname'];
                    usernameController.text = data['username'];
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: txtHeader('Your information:'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFieldWidget(
                            color: readOnly
                                ? const Color.fromRGBO(0, 0, 0, .1)
                                : inputFieldBgColor,
                            readOnly: readOnly,
                            controller: firstnameController,
                            label: 'Firstname:',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFieldWidget(
                            color: readOnly
                                ? const Color.fromRGBO(0, 0, 0, .1)
                                : inputFieldBgColor,
                            readOnly: readOnly,
                            controller: lastnameController,
                            label: 'Lastname:',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFieldWidget(
                            color: readOnly
                                ? const Color.fromRGBO(0, 0, 0, .1)
                                : inputFieldBgColor,
                            readOnly: readOnly,
                            controller: usernameController,
                            label: 'Username:',
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButtonWidget(
                            onPressed: () async {
                              if (readOnly) {
                                setState(() {
                                  readOnly = false;
                                });
                                return;
                              }
                              String? firstName = validate
                                  .validateFirstname(firstnameController.text);
                              String? lastName = validate
                                  .validateLastname(lastnameController.text);
                              String? userName = validate
                                  .validateUsername(usernameController.text);

                              if (firstName != null) {
                                showError(context, firstName);
                                return;
                              }
                              if (lastName != null) {
                                showError(context, lastName);
                                return;
                              }

                              if (userName != null) {
                                showError(context, userName);
                                return;
                              }

                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => const LoaderWidget(),
                              );
                              bool isUsed = await userFirestore.usernameIsUsed(
                                  usernameController.text.trim(),
                                  except: data['username']);

                              if (isUsed) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                  showError(context, 'Username already used.');
                                  return;
                                }
                              } else {
                                await userFirestore.updateUserData(
                                  UserModel(
                                    email: "",
                                    firstname: firstnameController.text.trim(),
                                    lastname: lastnameController.text.trim(),
                                    password: "",
                                    username: usernameController.text.trim(),
                                  ),
                                );
                                if (context.mounted) {
                                  context.goNamed('splash');
                                }
                              }
                            },
                            label: readOnly ? 'Update' : 'Save ',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: txtSubHeader('Others:'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutLineButtonWidget(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              await authServices.signOut();
                              if (context.mounted) {
                                context.goNamed('splash');
                              }
                            },
                            label: 'Logout',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutLineButtonWidget(
                            onPressed: () {
                              context.pushNamed('selectavatar');
                            },
                            label: 'Change avatar',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

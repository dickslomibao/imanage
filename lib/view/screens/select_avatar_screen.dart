import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imanage/utils/palette.dart';
import 'package:imanage/utils/text_util.dart';
import 'package:imanage/view/widgets/alert_dialog_loader.dart';
import 'package:imanage/view/widgets/elvatedbutton_widget.dart';
import 'package:username_gen/username_gen.dart';

class SelectAvatarScreen extends StatefulWidget {
  const SelectAvatarScreen({super.key});

  @override
  State<SelectAvatarScreen> createState() => _SelectAvatarScreenState();
}

class _SelectAvatarScreenState extends State<SelectAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              txtHeader('Select Your Avatar'),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    String url =
                        "https://api.multiavatar.com/${UsernameGen().generate()}.png?apikey=hCSoNROm6B3gp7";
                    return GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => const LoaderWidget(),
                        );
                        await FirebaseAuth.instance.currentUser!
                            .updatePhotoURL(url);

                        if (context.mounted) {
                          context.pushReplacement('/');
                        }
                      },
                      child: CircleAvatar(
                        child: Image.network(
                          url,
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButtonWidget(
                label: 'More avatar',
                onPressed: () {
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

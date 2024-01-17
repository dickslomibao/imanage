import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imanage/firebase_options.dart';
import 'package:imanage/routes.dart';
import 'package:imanage/services/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveServices.initHive();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      title: 'iManage',
      routerConfig: router,
      builder: EasyLoading.init(),
    );
  }
}

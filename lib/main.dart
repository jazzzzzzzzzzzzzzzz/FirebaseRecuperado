import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetask11/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firetask",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.manropeTextTheme()),
      home: HomePage(),
    );
  }
}

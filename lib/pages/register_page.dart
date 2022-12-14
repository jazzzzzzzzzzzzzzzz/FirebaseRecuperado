import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../services/my_service_firestore.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/button_custom_widget.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/textfield_normal_widget.dart';
import '../ui/widgets/textfield_password_widget.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  MyServiceFirestore userService = MyServiceFirestore(collection: "users");

  _registerUser() async {
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (userCredential.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        }
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        showSnackBarError(context, "La contraseña es muy débil");
      } else if (error.code == "email-already-in-use") {
        showSnackBarError(context, "El correo electrónico está en uso");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(children: [
              divider30(),
              SvgPicture.asset(
                "assets/images/register.svg",
                height: 180.0,
              ),
              divider20(),
              Text(
                "Regístrate",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: kBrandPrimaryColor),
              ),
              TextFieldNormalWidget(
                  hintText: "Nombre Completo",
                  icon: Icons.email,
                  controller: _fullnameController),
              TextFieldNormalWidget(
                  hintText: "Correo",
                  icon: Icons.email,
                  controller: _emailController),
              divider20(),
              TextFieldPasswordWidget(controller: _passwordController),
              divider10(),
              ButtonCustomWidget(
                text: "Registrate",
                color: kBrandPrimaryColor,
                icon: "check",
                onPressed: () {
                  _registerUser();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

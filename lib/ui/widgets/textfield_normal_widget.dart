import 'package:flutter/material.dart';

class TextFieldNormalWidget extends StatelessWidget {
  String hintText;
  IconData icon;
  Function? onTap;
  TextEditingController controller;
  TextFieldNormalWidget({
    required this.hintText,
    required this.icon,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap != null
          ? () {
              onTap!();
            }
          : null,
      readOnly: onTap != null ? true : false,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14.0, color: Color(0xff2C3550).withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none),
        // desbordamiento
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none),
      ),
      validator: (String? value) {
        if (value != null && value.isEmpty) {
          return "Campo obligatorio";
        }
      },
    );
  }
}

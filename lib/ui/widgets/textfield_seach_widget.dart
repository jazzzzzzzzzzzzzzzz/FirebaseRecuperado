import 'package:flutter/material.dart';
import '../general/colors.dart';

class TexFieldSeachWidget extends StatelessWidget {
  const TexFieldSeachWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        prefixIcon: Icon(
          Icons.search,
          size: 20.0,
          color: kBrandPrimaryColor.withOpacity(0.6),
        ),
        hintText: "Buscar tarea...",
        hintStyle: TextStyle(
          fontSize: 14.0,
          color: kBrandPrimaryColor.withOpacity(0.6),
        ),
        filled: true,
        fillColor: kBrandSecondaryColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

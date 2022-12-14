import 'package:flutter/material.dart';
import 'package:tareas/ui/general/colors.dart';

class ButtonNormalWidget extends StatelessWidget {
  Function onPressed;

  ButtonNormalWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.0,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(Icons.save),
        label: Text(
          "Guardar",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: kBrandPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            )),
      ),
    );
  }
}

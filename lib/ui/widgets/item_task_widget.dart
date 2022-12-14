import 'package:firebasetask11/ui/widgets/general_widgets.dart';
import 'package:firebasetask11/ui/widgets/item_categori_widget.dart';
import 'package:flutter/material.dart';

import '../general/colors.dart';

class ItemTaskWidget extends StatelessWidget {
  const ItemTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: const Offset(4, 4),
            blurRadius: 12.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemCategoryWidget(
            text: "Personal",
          ),
          divider3(),
          Text(
            "Loren ipsum dolor sit amet",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: kBrandPrimaryColor.withOpacity(0.85),
            ),
          ),
          Text(
            "Lorem ipsum solor",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: kBrandPrimaryColor.withOpacity(0.75),
            ),
          )
        ],
      ),
    );
  }
}
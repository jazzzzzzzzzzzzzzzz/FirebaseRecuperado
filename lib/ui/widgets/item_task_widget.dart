import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/my_service_firestore.dart';
import '../general/colors.dart';
import 'general_widgets.dart';
import 'item_categori_widget.dart';

class ItemTaskWidget extends StatelessWidget {
  TaskModel taskModel;
  ItemTaskWidget({required this.taskModel});
  final MyServiceFirestore _myServiceFirestore =
      MyServiceFirestore(collection: "tasks");

  showFinishiedDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Finalizar tarea",
                  style: TextStyle(
                      color: kBrandPrimaryColor.withOpacity(0.87),
                      fontWeight: FontWeight.w600),
                ),
                divider10(),
                Text(
                  "¿Deseas Finalizar esta tarea?",
                  style: TextStyle(
                      color: kBrandPrimaryColor.withOpacity(0.87),
                      fontWeight: FontWeight.w400),
                ),
                divider20(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                              color: kBrandPrimaryColor.withOpacity(0.5),
                              fontWeight: FontWeight.w400),
                        )),
                    divider20width(),
                    ElevatedButton(
                        onPressed: () {
                          _myServiceFirestore.finishiedTask(taskModel.id!);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: kBrandPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )),
                        child: Text("Finalizar"))
                  ],
                ),
              ],
            ),
          );
        });
  }

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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemCategoryWidget(
                  text: taskModel.category,
                ),
                divider3(),
                Text(
                  taskModel.title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    color: kBrandPrimaryColor.withOpacity(0.85),
                  ),
                ),
                divider6(),
                Text(
                  taskModel.description,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: kBrandPrimaryColor.withOpacity(0.75),
                  ),
                ),
                divider6(),
                Text(
                  taskModel.date,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: kBrandPrimaryColor.withOpacity(0.75),
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -12,
              child: PopupMenuButton(
                  elevation: 2,
                  color: Colors.white,
                  icon: Icon(
                    Icons.more_vert,
                    color: kBrandPrimaryColor.withOpacity(0.85),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  onSelected: (value) {
                    if (value == 2) {
                      showFinishiedDialog(context);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(value: 1, child: Text("Editar")),
                      PopupMenuItem(value: 2, child: Text("Finalizar")),
                    ];
                  }),
            )
          ],
        ));
  }
}

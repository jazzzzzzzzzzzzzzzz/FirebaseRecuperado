import 'package:flutter/material.dart';
import '../../models/task_model.dart';
import '../../services/my_service_firestore.dart';
import '../general/colors.dart';
import 'button_normal_widget.dart';
import 'general_widgets.dart';
import 'textfield_normal_widget.dart';

class TaskFormWidget extends StatefulWidget {
  const TaskFormWidget({super.key});

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  final formKey = GlobalKey<FormState>();

  MyServiceFirestore taskService = MyServiceFirestore(collection: "tasks");
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String categorySelected = "Personal";

  showSelectDate() async {
    DateTime? datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      cancelText: "Cancelar",
      confirmText: "Aceptar",
      helpText: "Seleccione fecha para la tarea",
      builder: (BuildContext context, Widget? widget) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogTheme: DialogTheme(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0))),
          ),
          child: widget!,
        );
      },
    );
    if (datetime != null) {
      _dateController.text = datetime.toString().substring(0, 10);
      setState(() {});
    }
  }

  registerTask() {
    if (formKey.currentState!.validate()) {
      //
      TaskModel taskModel = TaskModel(
        title: _titleController.text,
        description: _descriptionController.text,
        date: _dateController.text,
        category: categorySelected,
        status: true,
      );
      taskService.addTask(taskModel).then((value) {
        if (value.isNotEmpty) {
          Navigator.pop(context);
          showSnackBarSuccess(context, "La tarea se guardo con exito");
        }
      }).catchError((error) {
        showSnackBarError(
            context, "Se ha producido un error, vuelve a intentarlo");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0))),
        padding: EdgeInsets.all(14),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Agregar tarea",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
              ),
              TextFieldNormalWidget(
                hintText: "Titulo",
                icon: Icons.text_fields,
                controller: _titleController,
              ),
              TextFieldNormalWidget(
                hintText: "Descripción",
                icon: Icons.description,
                controller: _descriptionController,
              ),
              Text("Categoría"),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.start,
                spacing: 10.0,
                children: [
                  FilterChip(
                      selected: categorySelected == "Personal",
                      backgroundColor: kBrandSecondaryColor,
                      selectedColor: categoryColor[categorySelected],
                      checkmarkColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelStyle: TextStyle(
                          color: categorySelected == "Personal"
                              ? Colors.white
                              : kBrandPrimaryColor),
                      label: Text("Personal"),
                      onSelected: (bool value) {
                        categorySelected = "Personal";
                        setState(() {});
                      }),
                  FilterChip(
                      selected: categorySelected == "Trabajo",
                      backgroundColor: kBrandSecondaryColor,
                      selectedColor: categoryColor[categorySelected],
                      checkmarkColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelStyle: TextStyle(
                          color: categorySelected == "Trabajo"
                              ? Colors.white
                              : kBrandPrimaryColor),
                      label: Text("Trabajo"),
                      onSelected: (bool value) {
                        categorySelected = "Trabajo";
                        setState(() {});
                      }),
                  FilterChip(
                      selected: categorySelected == "Otro",
                      backgroundColor: kBrandSecondaryColor,
                      selectedColor: categoryColor[categorySelected],
                      checkmarkColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      labelStyle: TextStyle(
                          color: categorySelected == "Otro"
                              ? Colors.white
                              : kBrandPrimaryColor),
                      label: Text("Otro"),
                      onSelected: (bool value) {
                        categorySelected = "Otro";
                        setState(() {});
                      }),
                ],
              ),
              TextFieldNormalWidget(
                hintText: "Fecha",
                icon: Icons.date_range,
                controller: _dateController,
                onTap: () {
                  showSelectDate();
                },
              ),
              ButtonNormalWidget(
                onPressed: () {
                  registerTask();
                },
              ),
            ],
          ),
        ));
  }
}

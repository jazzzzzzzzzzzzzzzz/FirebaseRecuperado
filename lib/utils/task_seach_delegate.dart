import 'package:flutter/material.dart';

class TaskSearchDelegate extends SearchDelegate {
  List<TaskModel> tasks;
  //constructor
  TaskSearchDelegate({required this.tasks});

  List<String> names = ["Juan", "Calors", "Sara", "Vanesa"];

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar tarea ...";
  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(fontSize: 14);

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<TaskModel> results = tasks
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemTaskWidget(
            taskModel: results[index],
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<TaskModel> results = tasks
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemTaskWidget(
            taskModel: results[index],
          );
        },
      ),
    );
  }
}

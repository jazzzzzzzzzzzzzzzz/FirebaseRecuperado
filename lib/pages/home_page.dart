import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tareas/pages/login_page.dart';
import 'package:tareas/ui/general/colors.dart';

import 'package:tareas/ui/widgets/general_widgets.dart';
import 'package:tareas/ui/widgets/item_task_widget.dart';
import 'package:tareas/ui/widgets/task_form_widget.dart';

import '../models/task_model.dart';
import '../ui/widgets/textfield_normal_widget.dart';
import '../utils/task_seach_delegate.dart';

class HomePage extends StatelessWidget {
  List<TaskModel> tasksGeneral = [];

  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tareasfirebase');

  /*Stream<int> counter() async* {
    for (int i = 0; i < 10; i++) {
      yield i;
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  Future<int> getNumber() async {
    return 1000;
  }*/
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _searchController = TextEditingController();

  showTaskForm(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: TaskFormWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F6FF),
        floatingActionButton: InkWell(
          onTap: () {
            showTaskForm(context);
          },
          borderRadius: BorderRadius.circular(14.0),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: kBrandPrimaryColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Nueva tarea",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 22.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(18.0),
                    bottomLeft: Radius.circular(18.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Bienvenida Jazmin",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff2c3550),
                                  ),
                                ),
                                divider6(),
                                Text(
                                  "Mis tareas",
                                  style: TextStyle(
                                    fontSize: 36.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff2c3550),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                FacebookAuth.instance.logOut();
                                _googleSignIn.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              },
                              icon: Icon(Icons.exit_to_app),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: TextFieldNormalWidget(
                            icon: Icons.search,
                            hintText: "Buscar tarea",
                            controller: _searchController,
                            onTap: () async {
                              await showSearch(
                                  context: context,
                                  delegate:
                                      TaskSearchDelegate(tasks: tasksGeneral));
                            },
                          ),
                        ),
                      ]),
                ),
              ),
              divider10(),
              Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Todas mis tareas",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: kBrandPrimaryColor),
                      ),
                      StreamBuilder(
                        stream: tasksReference.snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (snap.hasData) {
                            List<TaskModel> tasks = [];
                            QuerySnapshot collection = snap.data;
                            /*
                    
                      collection.docs.forEach((element) {
                      Map<String,dynamic> myMap = element.data() as Map<String,dynamic>;
                      tasks.add(TaskModel.fromJson(myMap));
                      });*/

                            /*
                            tasks = collection.docs
                                .map((e) => TaskModel.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            */
                            tasks = collection.docs.map((e) {
                              TaskModel task = TaskModel.fromJson(
                                  e.data() as Map<String, dynamic>);
                              task.id = e.id;
                              return task;
                            }).toList();
                            tasksGeneral.clear();
                            tasksGeneral = tasks;

                            return ListView.builder(
                                itemCount: tasks.length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemTaskWidget(
                                    taskModel: tasks[index],
                                  );
                                });
                          }
                          return loadingWidget();
                        },
                      ),
                    ]),
              )
            ],
          ),
        )

        /* body: StreamBuilder(
        stream: tasksReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            QuerySnapshot collection = snap.data;
            List<QueryDocumentSnapshot> docs = collection.docs;
            List<Map<String, dynamic>> docsMap =
                docs.map((e) => e.data() as Map<String, dynamic>).toList();
            print(docsMap);
            return ListView.builder(
              itemCount: docsMap.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(docsMap[index]["title"]),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      */

        /* body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

  ----Primer boton-------------
            ElevatedButton(
              onPressed: () {
                tasksReference.get().then((QuerySnapshot value) {


                  // QuerySnapshot collection = value;
                  //List<QueryDocumentSnapshot> docs = collection.docs;
                  //QueryDocumentSnapshot doc = docs[1];
                  //print(doc.id);
                  //print(doc.data());



                  QuerySnapshot collection = value;
                  collection.docs.forEach((QueryDocumentSnapshot element) {
                    Map<String, dynamic> myMap =
                        element.data() as Map<String, dynamic>;
                    print(myMap["title"]);
                  });
                });
              },
              child: Text(
                "Obtener la data",
              ),
            ),
            
  ----Segundo boton-----

            ElevatedButton(
              onPressed: () {
                tasksReference.add(
                  {
                    "title": "Ir de comprar al super",
                    "descrption": "Debemos de comprar comida para todo el mes",
                  },
                ).then((DocumentReference value) {
                  print(value.id);
                }).catchError((error) {
                  print("Ocurrio un eroor en el registro");
                }).whenComplete(() {
                  print("El registro ha terminado");
                });
              },
              child: Text(
                "Agregar documento",
              ),
            ),

    ----Tercer boton --------------
            ElevatedButton(
              onPressed: () {
                tasksReference
                    .doc("GyD1GFkVD7p9JUPcDtF1")
                    .update({"title": "ir de paseo al campo"}).catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("Actualizacion terminada");
                  },
                );
              },
              child: Text(
                "Actualizar documento",
              ),
            ),

  ----Cuarto boton-------

            ElevatedButton(
              onPressed: () {
                tasksReference.doc("9TQHQz9R4Z8KLIc1ew1L").delete().catchError(
                  (error) {
                    print(error);
                  },
                ).whenComplete(
                  () {
                    print("La eliminacion esta completa");
                  },
                );
              },
              child: Text(
                "Eliminar documento",
              ),
            ),

  ----Quinto boton--------
            ElevatedButton(
              onPressed: () {
                tasksReference.doc("AB5559").set(
                  {
                    "title": "Ir al acampar",
                    "description": "Este fin de semana iremos a acampar"
                  },
                ).catchError((error) {
                  print(error);
                }).whenComplete(() {
                  print("Creacion completada");
                });
              },
              child: Text(
                "Agregar documento personalizado",
              ),
            )
          ],
        ),*/
        );
  }
}

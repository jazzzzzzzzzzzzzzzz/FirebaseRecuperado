import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetask11/ui/widgets/item_task_widget.dart';
import 'package:flutter/material.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/general_widgets.dart';
import '../ui/widgets/textfield_seach_widget.dart';

class HomePage extends StatelessWidget {
  //referencia de tareassssssssssssssssssssssss

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBrandSecondaryColor,
        floatingActionButton: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
            decoration: BoxDecoration(
              color: kBrandPrimaryColor,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  "Nueva Tarea",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
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
                    Text(
                      "Bienvenida, Jazmin",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    Text(
                      "Mis Tareas",
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.w600,
                        color: kBrandPrimaryColor,
                      ),
                    ),
                    divider10(),
                    TexFieldSeachWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Todas mis Tareas",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: kBrandPrimaryColor.withOpacity(0.85),
                    ),
                  ),
                  ItemTaskWidget(),
                ],
              ),
            )
          ]),
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

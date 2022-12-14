import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';

class MyServiceFirestore {
  String collection;
  MyServiceFirestore({required this.collection});

  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

/*para añadir*/
  Future<String> addTask(TaskModel model) async {
    DocumentReference documentReference =
        await _collectionReference.add(model.toJson());
    String id = documentReference.id;
    return id;
  }

  /*para borrar*/

  Future<void> finishiedTask(String taskId) async {
    await _collectionReference.doc(taskId).update(
      {
        "status": false,
      },
    );
  }

  /*para añadir un usuario*/
  Future<String> addUser(UserModel userModel) async {
    DocumentReference documentReference =
        await _collectionReference.add(userModel.toJson());
    return documentReference.id;
  }

  Future<bool> cherckUser(String email) async {
    QuerySnapshot collection =
        await _collectionReference.where("email", isEqualTo: email).get();
    if (collection.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

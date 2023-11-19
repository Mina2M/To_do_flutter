
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier{
  List<Task>taskList = [];

  void getAllTasksFromFireStore() async{
    QuerySnapshot<Task> querysnapshot = await FirebaseUtils.getTasksCollection().get();
    // List<QueryDocumentSnapshot<Task>>  => List<Task>
    taskList = querysnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    notifyListeners();
  }
}
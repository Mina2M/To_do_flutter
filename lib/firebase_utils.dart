
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/model/task.dart';

class FirebaseUtils{
  static CollectionReference<Task> getTasksCollection(){
    return FirebaseFirestore.instance.collection('tasks')
        .withConverter<Task>(
      fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
      toFirestore: (task, options) => task.toJson(),
    );
  }

  static Future<void> addTaskToFireStore(Task task){
    var taskCollection = getTasksCollection();
    DocumentReference<Task> docRef  = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }
}
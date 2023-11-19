import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/my_Theme.dart';
import 'package:test/task_list/task_widget.dart';

import '../firebase_utils.dart';
import '../model/task.dart';
import '../providers/list_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  // List<Task>taskList = [];

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if(listProvider.taskList.isEmpty){
      listProvider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: MyTheme.blackColor,
          dayColor: MyTheme.blackColor,
          activeDayColor: MyTheme.whiteColor,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          dotsColor: MyTheme.whiteColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidgetItem(task: listProvider.taskList[index]);
            },
            itemCount: listProvider.taskList.length,
          ),
        )
      ],
    );
  }

  // void getAllTasksFromFireStore() async{
  //   QuerySnapshot<Task> querysnapshot = await FirebaseUtils.getTasksCollection().get();
  //   // List<QueryDocumentSnapshot<Task>>  => List<Task>
  //   taskList = querysnapshot.docs.map((doc){
  //     return doc.data();
  //   }).toList();
  //   setState(() {
  //
  //   });
  // }
}

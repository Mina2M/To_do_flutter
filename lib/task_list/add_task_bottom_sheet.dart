import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/firebase_utils.dart';
import 'package:test/model/task.dart';
import 'package:test/providers/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);

    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Add new Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        title = value;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Enter Task Title'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {
                        description = value;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter task description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Task Description',
                      ),
                      maxLines: 4,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select Date'),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        textAlign: TextAlign.center),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if(formKey.currentState?.validate() == true){
      // add task to firebase
      Task task = Task(title: title, description: description, dateTime: selectedDate);
      FirebaseUtils.addTaskToFireStore(task).timeout(
        Duration(milliseconds: 500),
        onTimeout: (){
          print('todo added successful');
          listProvider.getAllTasksFromFireStore(); 
          Navigator.pop(context);
        }
      );
    }
  }
}

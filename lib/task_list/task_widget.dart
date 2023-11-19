import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:test/my_Theme.dart';

import '../model/task.dart';

class TaskWidgetItem extends StatelessWidget {
  Task task;
  TaskWidgetItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Slidable(

      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              bottomLeft: Radius.circular(18),
            ),
            onPressed: (context) {
              // delete task
            },
            backgroundColor: MyTheme.redColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: MyTheme.whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    task.title??'',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(task.description??'', style: Theme.of(context).textTheme.titleSmall),
                ),
              ],
            )),
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 7, vertical: 21),
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(Icons.check, size: 35, color: MyTheme.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

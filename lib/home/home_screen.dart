import 'package:flutter/material.dart';
import 'package:test/my_Theme.dart';
import 'package:test/settings/settings_tab.dart';
import 'package:test/task_list/add_task_bottom_sheet.dart';
import 'package:test/task_list/task_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To DO List',
        style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {

            });
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Task List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add, size: 30,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }
  List<Widget> tabs = [
    TaskListTab(),
    SettingsTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: ((context) => AddTaskBottomSheet())
    );
  }
}

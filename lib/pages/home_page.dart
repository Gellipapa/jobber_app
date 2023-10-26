import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_container.dart';
import 'package:todo_app/components/todo_container.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/pages/add_new_client_page.dart';
import 'package:todo_app/util/localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  Database db = new Database();

  int _currentIndex = 0;

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void onTaped(int index) {
    void changePage() {
      setState(() {
        _currentIndex = index;
      });
      Navigator.of(context).pop();
    }

    if (_currentIndex == 1) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogContainer(
            controller: _controller,
            onSave: changePage,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
      );
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoContainer(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
      AddNewClientPage(),
      Center(child: Text(loc.schedulePage)),
    ];

    return Scaffold(
      backgroundColor: Colors.blue[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: Icon(Icons.add),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTaped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: loc.homePage),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: loc.workPage),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: loc.schedulePage),
        ],
      ),
    );
  }
}

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todolist/main.dart';

import 'helpers.dart';

int counter = 0;

class TaskData extends ChangeNotifier {
  List<TaskToDo> _tasks = [
    //TaskToDo(title: 'Complete Flutter Bootcamp Course', id: counter),
    // Task(titleOfTask: 'Buy a RAM DDR4 2400Hz 8GB'),
    // Task(titleOfTask: 'Design some of screens to my app'),
  ];

  int get getCount {
    return _tasks.length;
  }

  int generateID() {
    return counter = _tasks.length + 1;
  }

  // void insertIntoDatabase(TaskToDo task) {
  //   //add function
  //   //dbHelper.insertTask(task);
  // }

  UnmodifiableListView<TaskToDo> get tasks {
    //retrieveTasks();
    taskDataList();
    return UnmodifiableListView(_tasks);
  }

  taskDataList() async {
    _tasks.addAll(await todoProvider.getAllTasks() as List<TaskToDo>);
  }

  void addTask(String newTaskTitle) {
    TaskToDo taskToDo = TaskToDo(title: newTaskTitle, id: generateID());
    _tasks.add(taskToDo);
    todoProvider.insert(_tasks.last);
    //insertIntoDatabase(Task(title: newTaskTitle));
    // retrieveTasks();
    //taskDataList();
    notifyListeners();
  }

  void deleteTask(TaskToDo task) {
    _tasks.remove(task);
    todoProvider.delete(task.id);
    //dbHelper.deleteTask((task.title));
    notifyListeners();
  }

  void updateTaskState(TaskToDo task) async {
    task.toggleDone();
    todoProvider.update(task);
    notifyListeners();
  }

// void retrieveTasks() async {
//   _tasks = await dbHelper.allTasks();
// }
}

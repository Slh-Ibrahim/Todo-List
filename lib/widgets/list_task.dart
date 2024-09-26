import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task_data.dart';

import 'list_tile.dart';

class TasksList extends StatelessWidget {
  // final List<Task> tasks;
  // TasksList({required this.tasks});

//   @override
//   _TasksListState createState() => _TasksListState();
// }
//
// class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final currentTask = taskData.tasks[index]; //***************//
            return TaskTile(
              taskTitle: currentTask.title,
              isChecked: currentTask.getDone,
              checkboxCallBack: () {
                taskData.updateTaskState(currentTask);
              },
              onLongPressCallback: () {
                taskData.deleteTask(currentTask);
              },
              id: currentTask.id,
            );
          },
          itemCount: taskData.getCount,
        );
      },
    );
  }
}
// (state) {
// setState(() {
// tasks[index].toggleDone();
// });
// },

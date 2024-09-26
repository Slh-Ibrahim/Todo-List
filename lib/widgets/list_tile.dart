import 'package:flutter/material.dart';
import 'package:todolist/screens/task_screen.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function checkboxCallBack;
  final Function onLongPressCallback;
  final int id;

  TaskTile({
    required this.taskTitle,
    required this.isChecked,
    required this.checkboxCallBack,
    required this.onLongPressCallback,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showToast('Hold press to remove the task {ID : $id }');
      },
      onLongPress: () {
        onLongPressCallback();
      },
      title: Text(
        taskTitle,
        style: TextStyle(
            color: Colors.black,
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: isChecked,
        checkColor: Colors.white,
        activeColor: Colors.teal,
        onChanged: (newValue) {
          checkboxCallBack();
        },
      ),
    );
  }
}
// fToast.showToast(
// child: toast,
// toastDuration: Duration(seconds: 2),
// positionedToastBuilder: (context, child) {
// return Positioned(
// child: child,
// top: 16.0,
// left: 16.0,
// );
// });

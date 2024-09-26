import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task_data.dart';
import 'package:todolist/screens/task_screen.dart';

String valOfTextF = '';

class AddTaskScreen extends StatelessWidget {
  // final myController = TextEditingController();
  //
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding:
            EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          border: Border(
            top: BorderSide.none,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              onChanged: (val) {
                valOfTextF = val;
              },
              //controller: myController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.teal,
                  width: 2.3,
                )),
              ),
              autofocus: true,
              cursorColor: Colors.teal,
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(
                forceStrutHeight: false,
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {
                if (valOfTextF.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(valOfTextF);
                  valOfTextF = '';
                  Navigator.pop(context);
                } else {
                  showToast('write the task');
                }
                // setState(() {
                //   TasksList(
                //     addToList: () {
                //       setState(() {
                //         tasks.add(Task(name: myController.text));
                //       });
                //     },
                //   );
                //   //addTaskToList(myController.text);
                //   // void addTaskToList(String txt) {
                //   //
                //   //   tasks.add(Task(name: txt));
                //   // }
                // });
                // // Navigator.popAndPushNamed(context, TasksScreen());
                // Navigator.pop(context);
                //  print(myController.text);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.tealAccent;
                    return Colors.teal;
                    // Use the component's default.
                  },
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task_data.dart';

import 'models/helpers.dart';
import 'screens/task_screen.dart';

void main() {
  runApp(MyApp());
}

TodoProvider todoProvider = TodoProvider();
//DbHelper dbHelper = DbHelper();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TaskData(),
      child: MaterialApp(
        // theme: ThemeData.dark().copyWith(
        //     //unselectedWidgetColor: Colors.white,
        //     ),
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}

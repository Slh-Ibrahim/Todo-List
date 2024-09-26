import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class TaskToDo {
  late int id;
  late String title;
  late bool done = false;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  void toggleDone() {
    done = !done;
  }

  get getDone => done;

  TaskToDo({required this.title, required this.id});

  TaskToDo.fromMap(Map<String?, Object?> map) {
    id = map[columnId] as int;
    title = map[columnTitle].toString();
    done = map[columnDone] == 1;
  }

  TaskToDo.fromMaps(List<Map> maps) {
    for (int index = 0; index < maps.length; index++) {
      id = maps[index][columnId] as int;
      title = maps[index][columnTitle].toString();
      done = maps[index][columnDone] == 1;
    }
  }
}

class TodoProvider {
  static final TodoProvider _instance = TodoProvider.internal();

  factory TodoProvider() => _instance;

  TodoProvider.internal();

  static late Database db;

  Future open() async {
    if (db != null) {
      return db;
    }
    String path = join(await getDatabasesPath(), 'todolist.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
    });
    print('The path is = $path');
  }

  Future<TaskToDo> insert(TaskToDo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<TaskToDo?> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return TaskToDo.fromMap(maps.first[columnId][columnTitle][columnDone]);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<bool> update(TaskToDo todo) async {
    await db.execute(
        'UPDATE $tableTodo SET done=${todo.getDone}, where $columnId = ${todo.id}');
    // if (await db
    //         .query('select done from $tableTodo where $columnId=${//todo.id}') !=
    //     null)
    //   return true;
    // else
    return true;
  }

  Future<TaskToDo?> getAllTasks() async {
    List<Map> maps = await db.query(
      tableTodo,
      columns: [columnId, columnDone, columnTitle],
    );
    if (maps.length > 0) {
      return TaskToDo.fromMaps(maps);
    }
    return null;
  }

  Future close() async => db.close();
}

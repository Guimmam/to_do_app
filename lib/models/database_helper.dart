import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/todo.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'todo.db'),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)");
      await db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY,taskId INTEGER, title TEXT, isDone INTEGER)");
      return Future.value(db);
    }, version: 1);
  }

  Future<void> insertTask(Task task) async {
    Database _db = await database();

    var taskToInsert = {'title': task.title, 'description': task.description};
    await _db.insert('tasks', taskToInsert,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
    print(todo.toMap());
    var taskToInsert = {'title': todo.title, 'isDone': todo.isDone};
    await _db.insert('todos', taskToInsert,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');

    return List.generate(
      taskMap.length,
      (index) => Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']),
    );
  }
}

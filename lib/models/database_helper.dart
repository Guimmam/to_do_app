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
      // ignore: void_checks
      return Future.value(db);
    }, version: 1);
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;

    Database _db = await database();

    var taskToInsert = {'title': task.title, 'description': task.description};
    await _db
        .insert('tasks', taskToInsert,
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      taskId = value;
    });
    return taskId;
  }

  Future<void> deleteTask(int taskId) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM tasks WHERE id= '$taskId'");
    await _db.rawDelete("DELETE FROM todos WHERE taskId = '$taskId'");
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateTaskDescription(int id, String description) async {
    Database _db = await database();
    await _db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE id = '$id'");
  }

  Future<void> insertTodo(Todo todo) async {
    Database _db = await database();
   
    var todoToInsert = {
      'taskId': todo.taskId,
      'title': todo.title,
      'isDone': todo.isDone
    };
    await _db.insert('todos', todoToInsert,
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

  Future<List<Todo>> getTodos(int taskId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery('SELECT * FROM todos WHERE taskId = $taskId');

    return List.generate(
      todoMap.length,
      (index) => Todo(
          id: todoMap[index]['id'],
          taskId: todoMap[index]['taskId'],
          title: todoMap[index]['title'],
          isDone: todoMap[index]['isDone']),
    );
  }

  Future<void> updateTodoIsDone(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todos SET isDone = '$isDone' WHERE id = '$id'");
  }
}

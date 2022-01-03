import 'package:flutter/material.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/widgets/to_do.dart';

class TaskScreen extends StatefulWidget {
  final Task task;
  const TaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String _taskTitle = "";
  int _taskId = 0;
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    if (widget.task.title != '') {
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFFE3577),
        child: Icon(
          Icons.delete_forever,
          size: 30,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) async {
                        print(value);
                        if (!value.isEmpty) {
                          Task _newTask = Task(title: value);
                          await _dbHelper.insertTask(_newTask);
                        }
                      },
                      controller: TextEditingController()..text = _taskTitle,
                      decoration: InputDecoration(
                        hintText: 'Enter Task title',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF211551)),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter Description for the task',
                      border: InputBorder.none),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: _dbHelper.getTodos(_taskId),
                    builder: (context, AsyncSnapshot<List<Todo>> snapshot) =>
                        ListView.builder(
                            itemCount:
                                snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (context, index) => TodoWidget(
                                  isDone: snapshot.data![index].isDone == 0
                                      ? false
                                      : true,
                                  text: snapshot.data![index].title,
                                ))),
              ),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onChanged: (_) {},
                  ),
                  Expanded(
                      child: TextField(
                    onSubmitted: (value) async {
                      print(value);
                      if (value.isNotEmpty) {
                        DatabaseHelper _dbHelper = DatabaseHelper();

                        Todo _newTodo = Todo(
                            title: value, taskId: widget.task.id, isDone: 0);
                        await _dbHelper.insertTodo(_newTodo);
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter ToDo item...",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

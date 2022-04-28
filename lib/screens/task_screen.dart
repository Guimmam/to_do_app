// ignore_for_file: use_full_hex_values_for_flutter_colors

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
  String _taskDescription = "";
  int _taskId = 0;

  final DatabaseHelper _dbHelper = DatabaseHelper();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  final FocusNode _todoFocus = FocusNode();

  final todoItemControler = TextEditingController();

  bool _contentvisible = false;

  @override
  void initState() {
    if (widget.task.title != '') {
      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
      _contentvisible = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _contentvisible
          ? FloatingActionButton(
              onPressed: () {
                _dbHelper.deleteTask(_taskId);
                Navigator.pop(context);
              },
              backgroundColor: const Color(0xFFFE3577),
              child: const Icon(
                Icons.delete_forever,
                size: 30,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            )
          : Container(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                ),
                Expanded(
                  child: TextField(
                    focusNode: _titleFocus,
                    onSubmitted: (value) async {
                      if (_taskTitle.isEmpty) {
                        if (value.isNotEmpty) {
                          Task _newTask = Task(title: value);
                          _taskId = await _dbHelper.insertTask(_newTask);
                          setState(() {
                            _contentvisible = true;
                            _taskTitle = value;
                          });
                        }
                      } else {
                        await _dbHelper.updateTaskTitle(_taskId, value);
                        
                      }
                      _descriptionFocus.requestFocus();
                    },
                    controller: TextEditingController()..text = _taskTitle,
                    decoration: const InputDecoration(
                      hintText: 'Enter Task title',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffff211551)),
                  ),
                )
              ],
            ),
            Visibility(
              visible: _contentvisible,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: TextField(
                  focusNode: _descriptionFocus,
                  controller: TextEditingController()..text = _taskDescription,
                  decoration: const InputDecoration(
                      hintText: 'Enter Description for the task',
                      border: InputBorder.none),
                  onSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      if (_taskId != 0) {
                        await _dbHelper.updateTaskDescription(_taskId, value);
                        _taskDescription = value;
                      }
                    }

                    _todoFocus.requestFocus();
                  },
                ),
              ),
            ),
            Visibility(
              visible: _contentvisible,
              child: Expanded(
                child: FutureBuilder(
                    future: _dbHelper.getTodos(_taskId),
                    builder: (context, AsyncSnapshot<List<Todo>> snapshot) =>
                        ListView.builder(
                            itemCount:
                                snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () async {
                                    if (snapshot.data![index].isDone == 0) {
                                      await _dbHelper.updateTodoIsDone(
                                          snapshot.data![index].id, 1);
                                    } else {
                                      await _dbHelper.updateTodoIsDone(
                                          snapshot.data![index].id, 0);
                                    }
                                    setState(() {});
                                  },
                                  child: TodoWidget(
                                    isDone: snapshot.data![index].isDone == 0
                                        ? false
                                        : true,
                                    text: snapshot.data![index].title,
                                  ),
                                ))),
              ),
            ),
            Visibility(
              visible: _contentvisible,
              child: Row(
                children: [
                  Checkbox(
                    value: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onChanged: (_) {},
                  ),
                  Expanded(
                      child: TextField(
                    controller: todoItemControler,
                    focusNode: _todoFocus,
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        if (_taskId != 0) {
                          DatabaseHelper _dbHelper = DatabaseHelper();

                          Todo _newTodo =
                              Todo(title: value, taskId: _taskId, isDone: 0);
                          await _dbHelper.insertTodo(_newTodo);
                          todoItemControler.clear();
                          _todoFocus.requestFocus();
                          setState(() {});
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter ToDo item...",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

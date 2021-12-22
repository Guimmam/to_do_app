import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/to_do.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
                      onSubmitted: (value) {
                        print(value);
                      },
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
              ToDo(
                isDone: true,
                text: 'To do widget',
              ),
              ToDo(
                isDone: true,
                text: 'Create second task',
              ),
              ToDo(
                isDone: false,
                text: 'Just another todo',
              ),
              ToDo(),
            ],
          ),
        ),
      ),
    );
  }
}

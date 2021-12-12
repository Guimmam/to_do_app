import 'package:flutter/material.dart';

class ToDo extends StatefulWidget {
  final String text;
  bool isDone;

  ToDo({
    Key? key,
    this.text = '(Unnamed todo)',
    this.isDone = false,
  }) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              value: widget.isDone,
              onChanged: (value) {
                setState(() {
                  widget.isDone = value!;
                });
              },
            ),
            Text(
              'To do widget ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

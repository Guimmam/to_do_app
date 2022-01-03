import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  final String text;
  bool isDone;

  TodoWidget({
    Key? key,
    this.text = '(Unnamed todo)',
    this.isDone = false,
  }) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
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
              widget.text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

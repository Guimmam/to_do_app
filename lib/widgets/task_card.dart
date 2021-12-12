import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;

  const TaskCard({
    Key? key,
    this.title = 'No title added',
    this.description = 'No description added',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF86829D),
              ),
            ),
          )
        ],
      ),
    );
  }
}

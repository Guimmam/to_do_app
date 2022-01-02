import 'package:flutter/cupertino.dart';

class Task {
  final int id;
  final String title;
  final String description;

  Task(
      {this.id = 0,
      required this.title,
      this.description = "No Description Added"});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}

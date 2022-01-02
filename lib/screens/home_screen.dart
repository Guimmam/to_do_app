import 'package:flutter/material.dart';
import 'package:to_do_app/models/database_helper.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/screens/task_screen.dart';
import 'package:to_do_app/widgets/task_card.dart';
import 'task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper _dbHelper = DatabaseHelper();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Task task = Task(title: '');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskScreen(
                        task: task,
                      ))).then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          color: Color(0xFFF6F6F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32, top: 32),
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot<List<Task>> snapshot) =>
                          ListView.builder(
                            itemCount:
                                snapshot.hasData ? snapshot.data!.length : 0,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskScreen(
                                              task: snapshot.data![index],
                                            )));
                              },
                              child: TaskCard(
                                title: snapshot.data![index].title,
                                description: snapshot.data![index].description,
                              ),
                            ),
                          )))
            ],
          ),
        ),
      ),
    );
  }
}


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
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          color: const Color(0xFFF6F6F6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 32, top: 32),
                child: const Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                        int todosQuantity =
                            snapshot.hasData ? snapshot.data!.length : 0;

                        if (todosQuantity == 0) {
                          return const Center(
                              child: Text(
                            'Looks like there are no todos :(',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ));
                        } else {
                          return ListView.builder(
                            itemCount: todosQuantity,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskScreen(
                                              task: snapshot.data![index],
                                            ))).then((value) {
                                  setState(() {});
                                });
                              },
                              child: TaskCard(
                                title: snapshot.data![index].title,
                                description: snapshot.data![index].description,
                              ),
                            ),
                          );
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

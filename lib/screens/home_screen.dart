import 'package:flutter/material.dart';
import 'package:to_do_app/screens/task_screen.dart';
import 'package:to_do_app/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskScreen()));
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
                child: ListView(
                  children: [
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

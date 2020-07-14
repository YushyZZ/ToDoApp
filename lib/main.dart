import 'package:ToDoApp/CreateTaskScreen.dart';
import 'package:flutter/material.dart';
import 'Appbar.dart';
import 'HomeBody.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ToDoAppHome(),
      routes: {
        "": (context) => ToDoAppHomeBody(),
        "/createtaskscreen": (context) => CreateTaskScreen()
      },
    );
  }
}

class ToDoAppHome extends StatefulWidget {
  @override
  _ToDoAppHomeState createState() => _ToDoAppHomeState();
}

class _ToDoAppHomeState extends State<ToDoAppHome> {
  String showingTimee;

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        child: Appbar(
          size
        ),
        preferredSize: Size(size.width, size.height * 0.09),
      ),
      backgroundColor: Colors.white,
      body: ToDoAppHomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pop(context);
            Navigator.of(context).pushNamed("/createtaskscreen");
          });
        },
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/img/plus.png",
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}

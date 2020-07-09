import 'package:ToDoApp/CreateTaskScreen.dart';
import 'package:flutter/material.dart';
import 'Appbar.dart';
import 'HomeBody.dart';
import "AbsorbedHome.dart";
import "./widgets/createTaskListMenu.dart";

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
      routes: {"/createtaskscreen": (context) => CreateTaskScreen()},
    );
  }
}

class ToDoAppHome extends StatefulWidget {
  @override
  _ToDoAppHomeState createState() => _ToDoAppHomeState();
}

class _ToDoAppHomeState extends State<ToDoAppHome> {
  bool isPressedFloating = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    
    return Scaffold(
      appBar: PreferredSize(
        child: Appbar(
          size: size,
        ),
        preferredSize: Size(size.width, size.height * 0.09),
      ),
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        (isPressedFloating == true)
            ? GestureDetector(child: AbsorbedHome(size: size),onTap: (){setState(() {
              isPressedFloating = false;
            });},)
            : ToDoAppHomeBody(),
        (isPressedFloating == true)
            ? CreateTaskListMenu(size: size)
            : Container()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isPressedFloating == true) {
              isPressedFloating = false;
            } else if (isPressedFloating == false) {
              isPressedFloating = true;
            }
          });
        },
        backgroundColor: Colors.blue,
        child: Image.asset(
          "assets/img/plus.png",
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}

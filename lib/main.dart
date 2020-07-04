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
    return MaterialApp(home: ToDoAppHome());
  }
}

class ToDoAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(child: Appbar(size: size,),preferredSize: Size(size.width,size.height*0.09),),
      backgroundColor: Colors.white,
      body: ToDoAppHomeBody()
    );
  }
}

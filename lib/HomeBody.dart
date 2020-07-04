import 'package:flutter/material.dart';
import './widgets/TaskWidget.dart';

class ToDoAppHomeBody extends StatefulWidget {
  @override
  _ToDoAppHomeBodyState createState() => _ToDoAppHomeBodyState();
}

class _ToDoAppHomeBodyState extends State<ToDoAppHomeBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: size.height * 0.33,
            child: ListView.builder(
              itemBuilder: (BuildContext ctxt, int index) {
                return new TaskWidget();
              },
              itemCount: 1,),
          ),
          Spacer(),
          Container(
              color: Colors.blue,
              height: size.height * 0.53,
              child:
                  ListView.builder(itemBuilder: (BuildContext ctxt, int index) {
                return new Text("$index");
              }))
        ],
      ),
    );
  }
}

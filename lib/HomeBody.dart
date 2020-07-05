import 'package:flutter/material.dart';
import './widgets/TaskWidget.dart';
import './widgets/ListWidget.dart';
import "./models/tasks.dart";
import "./models/lists.dart";

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
                return new TaskWidget(tasks[index]["taskName"],tasks[index]["isScheduled"],tasks[index]["time"],tasks[index]["listColor"]);
              },
              itemCount: tasks.length,
            ),
          ),
          Spacer(),
          Container(
            height: size.height * 0.53,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: size.width * 0.65),
                  height: size.height * 0.05,
                  child: Text(
                    "Lists",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xffC4C4C4)),
                  ),
                  padding: EdgeInsets.only(top: 10),
                ),
                Container(
                  color: Colors.white,
                  height: size.height * 0.48,
                  child: ListView.builder(
                      itemCount: lists.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new ListWidget(lists[index]["listName"],lists[index]["listColor"],lists[index]["itemCount"],);
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

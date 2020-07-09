import 'package:ToDoApp/widgets/TaskWidgetonListScreen.dart';
import 'package:flutter/material.dart';
import '../models/tasks.dart';

class ListPage extends StatelessWidget {
  final Size size;
  final Color listColor;
  final String listName;
  final int itemCount;

  ListPage(this.size, this.listColor, this.listName, this.itemCount);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          height: size.height * 0.95,
          color: Colors.transparent, //could change this to Color(0xFF737373),
          //so you don't have to change MaterialApp canvasColor
          child: new Container(
            decoration: new BoxDecoration(
              color: listColor,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height * 0.15,
                  margin: EdgeInsets.only(top: 20),
                  padding:
                      EdgeInsets.only(left: 30, right: 5, top: 20, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: size.height * 0.06,
                            width: size.width * 0.7,
                            child: Text(
                              "$listName",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            height: size.height * 0.03,
                            width: size.width * 0.7,
                            child: Text("$itemCount tasks",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: size.height * 0.04,
                            left: size.width * 0.09),
                        child: InkWell(
                          child: Image.asset(
                            "assets/img/Edit.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.775,
                  width: size.width * 1,
                  child: ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (BuildContext ctxt, int index) {
                      for (var index = 0;
                          index <= tasks.length - 1;
                          index += 1) {
                        if (tasks[index]["listName"] == listName) {
                          return new TaskWidgetOnList(
                              tasks[index]["taskName"],
                              tasks[index]["isScheduled"],
                              tasks[index]["time"],
                              tasks[index]["listColor"],
                              tasks[index]["isDated"],
                              tasks[index]["date"],
                              tasks[index]["isDone"],);
                        }
                      }
                     return null; 
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

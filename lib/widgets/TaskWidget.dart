import 'package:flutter/material.dart';
import '../models/tasks.dart';

class TaskWidget extends StatefulWidget {
  final String taskName;
  final bool isScheduled;
  final String time;
  final Color listColor;
  final bool isDone;

  TaskWidget(this.taskName, this.isScheduled, this.time, this.listColor , this.isDone);

  @override
  _TaskWidgetState createState() =>
      _TaskWidgetState(taskName, isScheduled, time, listColor , isDone);
}

class _TaskWidgetState extends State<TaskWidget> {

  final String taskName;
  final bool isScheduled;
  final String time;
  final Color listColor;
  bool isDone;

  _TaskWidgetState(this.taskName, this.isScheduled, this.time, this.listColor , this.isDone);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.08,
      width: size.width,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            value: isDone,
            onChanged: (bool value) {
              setState(() {
                isDone = value;
                for (var index = 0; index <= tasks.length-1; index += 1) {
                if (tasks[index]["taskName"] == taskName) {
                  tasks[index]["isDone"] = value;
                }
              }

              });
            },
          ),
          Column(children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          
                          width: size.width*0.8,
                          child: Text(
                            "$taskName",
                            style: TextStyle(
                                color: (!isDone)
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        isScheduled
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image(
                                    image: (!isDone)
                                        ? AssetImage(
                                            "assets/img/clock_enabled.png")
                                        : AssetImage(
                                            "assets/img/clock_disabled.png"),
                                  ),
                                  Text(
                                    "$time",
                                    style: TextStyle(
                                        color: (!isDone)
                                            ? Colors.black
                                            : Colors.grey),
                                  )
                                ],
                              )
                            : Text("")
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.01),
                    child: SizedBox(
                      height: 13,
                      width: 13,
                      child: RaisedButton(
                        color: listColor,
                        onPressed: null,
                        disabledColor: listColor,
                        shape: CircleBorder(),
                      ),
                    ),
                  )
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}

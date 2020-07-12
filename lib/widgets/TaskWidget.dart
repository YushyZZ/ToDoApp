import 'package:ToDoApp/utils/Database.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final String taskName;
  final int isScheduled;
  final String time;
  final String listColor;
  final int isDone;

  TaskWidget(
      this.taskName, this.isScheduled, this.time, this.listColor, this.isDone);

  @override
  _TaskWidgetState createState() =>
      _TaskWidgetState(taskName, isScheduled, time, listColor, isDone);
}

class _TaskWidgetState extends State<TaskWidget> {
  final String taskName;
  final int isScheduled;
  final String time;
  String listColor;
  int isDone;

  bool isDoneb;
  Color realColor;

  _TaskWidgetState(
      this.taskName, this.isScheduled, this.time, this.listColor, this.isDone);

  @override
  void initState() {
    intToBool();
    stringToColor();
    super.initState();
  }

  // ignore: missing_return
  void intToBool() {
    if (isDone == 1) {
      isDoneb = true;
      
    } else if (isDone == 0) {
      isDoneb = false;
    }
  }

  // ignore: missing_return
  void stringToColor() {
    
    if (listColor == "Color(0xff22a1d4)") {
      realColor =  Color(0xff22a1d4);
    }
    else if (listColor == "Color(0xfff29a0c)") {
      realColor = Color(0xfff29a0c);
    }
    else if (listColor == "Color(0xffe7f20c)") {
      realColor = Color(0xffe7f20c);
    }
    else if (listColor == "Color(0xffc92a9c)") {
      realColor = Color(0xffc92a9c);
    }
    else if (listColor == "Color(0xff050505)") {
      realColor = Color(0xff050505);
    }
    else if (listColor == "Color(0xff20c723)") {
      realColor = Color(0xff20c723);
    }
  }

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
            value: isDoneb,
            onChanged: (bool value) {
              setState(() {
                isDoneb = value;

                if (value == true) {int valueN = 1; DBProvider.db.changeisDoneStatus(taskName, valueN); }
                else if (value == false) {int valueN = 0; DBProvider.db.changeisDoneStatus(taskName, valueN); }

               
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
                          width: size.width * 0.8,
                          child: Text(
                            "$taskName",
                            style: TextStyle(
                                color: (!isDoneb) ? Colors.black : Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        isScheduled == 1
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image(
                                    image: (!isDoneb)
                                        ? AssetImage(
                                            "assets/img/clock_enabled.png")
                                        : AssetImage(
                                            "assets/img/clock_disabled.png"),
                                  ),
                                  Text(
                                    "$time",
                                    style: TextStyle(
                                        color: (!isDoneb)
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
                        color: realColor,
                        onPressed: null,
                        disabledColor: realColor,
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

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class TaskWidgetOnList extends StatefulWidget {
  final String taskName;
  final int isScheduled;
  final String time;
  final String listColor;
  final int isDated;
  final String date;
  int isDone;

  TaskWidgetOnList(this.taskName, this.isScheduled, this.time, this.listColor,
      this.isDated, this.date, this.isDone);

  @override
  _TaskWidgetOnListState createState() => _TaskWidgetOnListState(
      this.taskName,
      this.isScheduled,
      this.time,
      this.listColor,
      this.isDated,
      this.date,
      this.isDone);
}

class _TaskWidgetOnListState extends State<TaskWidgetOnList> {
  bool checkboxvalue = false;

  final String taskName;
  final int isScheduled;
  final String time;
  final String listColor;
  final int isDated;
  final String date;
  int isDone;

  _TaskWidgetOnListState(this.taskName, this.isScheduled, this.time,
      this.listColor, this.isDated, this.date, this.isDone);


  Color realColor;
  bool realisScheduled;
  bool realisDated;
  bool realisDone;

  void initState() {
    intToBool();
    stringToColor();
  }

  void intToBool() {
    if (isDone == 1) {
      realisDone = true;
      
    } else if (isDone == 0) {
      realisDone = false;
    }

    if (isScheduled == 1) {
      realisScheduled = true;
      
    } else if (isScheduled == 0) {
      realisScheduled = false;
    }

    if (isDated == 1) {
      realisDated = true;
      
    } else if (isDated == 0) {
      realisDated = false;
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
      height: size.height * 0.082,
      width: size.width,
      color: realColor,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: size.width * 0.03),
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(width: 3, color: Colors.white)),
            child: Checkbox(
                value: realisDone,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: null),
          ),
          Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: size.width * 0.04),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$taskName",
                          style: TextStyle(
                              color:
                                  (!checkboxvalue) ? Colors.white : Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(children: <Widget>[
                          realisDated
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.grey,
                                        size: 17,
                                      ),
                                      Text(
                                        " $date",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )
                              : Text(""),
                          realisScheduled
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: realisDated
                                          ? size.width * 0.02
                                          : size.width * 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Image(
                                        image: AssetImage(
                                            "assets/img/clock_disabled.png"),
                                      ),
                                      Text(
                                        "$time",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )
                              : Text("")
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}

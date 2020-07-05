import 'package:flutter/material.dart';

class TaskWidgetOnList extends StatefulWidget {
  @override
  _TaskWidgetOnListState createState() => _TaskWidgetOnListState();
}

class _TaskWidgetOnListState extends State<TaskWidgetOnList> {
  bool checkboxvalue = false;

  final String taskName;
  final bool isScheduled;
  final String time;
  final Color listColor;
  final bool isDated;
  final String date;

  _TaskWidgetOnListState(
      {this.taskName = "Taskname",
      this.isScheduled = true,
      this.time = " 00:00",
      this.listColor = Colors.transparent,
      this.isDated = true,
      this.date = "01.01.2020"});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.082,
      width: size.width,
      color: listColor,
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
              value: checkboxvalue,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              onChanged: (bool value) {
                print(value);
                setState(() {
                  checkboxvalue = value;
                });
              },
            ),
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
                          isDated
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.date_range , color: Colors.grey, size: 17,),
                                      Text(
                                        " $date",
                                        style: TextStyle(
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )
                              : Text(""),
                          isScheduled
                              ? Container(
                                  padding:
                                      EdgeInsets.only(left: isDated ? size.width * 0.02 : size.width*0),
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
                                        style: TextStyle(
                                            color:Colors.grey),
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

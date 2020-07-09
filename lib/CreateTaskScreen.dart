import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "./models/lists.dart";
import './models/tasks.dart';
import 'widgets/ListWidgetOnCreateTaskScreen.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  bool isDateButtonActive = false;
  bool isScheduleButtonActive = false;
  bool isSelectListButtonActive = false;

  List selectedListCustoms = ["List Name", Colors.black];

  String taskName;
  String datee;
  String timee;
  String listName;
  Color listColor;
  bool isScheduled = false;
  bool isDated = false;

  callback(newselectedListCustoms) {
    setState(() {
      selectedListCustoms = newselectedListCustoms;
      listName = newselectedListCustoms[0];
      listColor = newselectedListCustoms[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            topArea(size),
            taskPreview(size),
            SizedBox(
              height: isDateButtonActive |
                      isScheduleButtonActive |
                      isSelectListButtonActive
                  ? size.height * 0.32
                  : size.height * 0.68 -
                      MediaQuery.of(context).viewInsets.bottom,
            ),
            Divider(),
            oparations(size, context),
            isDateButtonActive
                ? Container(
                    height: size.height * 0.34,
                    child: CalendarDatePicker(
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2099),
                      onDateChanged: (date) {
                        setState(() {
                          datee = DateFormat("yyyy-MM-dd").format(date);
                          isDated = true;
                        });
                      },
                    ))
                : Container(),
            isScheduleButtonActive
                ? Container(
                    height: size.height * 0.34,
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              TextStyle(fontSize: 35, color: Colors.black),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        use24hFormat: false,
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (time) {
                          setState(() {
                            timee = DateFormat("hh:mm").format(time);
                            isScheduled = true;
                          });
                        },
                      ),
                    ))
                : Container(),
            isSelectListButtonActive
                ? Container(
                    height: size.height * 0.34,
                    child: ListView.builder(
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new ListWidgetOnCreateScreen(
                            lists[index]["listName"],
                            lists[index]["listColor"],
                            lists[index]["itemCount"],
                            lists[index]["isSelectedOnCreateScreen"],
                            callback);
                      },
                      itemCount: lists.length,
                    ))
                : Container(),
          ]),
        ));
  }

  Container topArea(Size size) {
    return Container(
      padding: EdgeInsets.only(
          left: size.width * 0.03,
          right: size.width * 0.03,
          top: size.height * 0.05),
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
          RaisedButton(
            color: Colors.white,
            elevation: 0,
            child: Text(
              "Done",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              tasks.add({
                "taskName": "$taskName",
                "isScheduled": isScheduled,
                "date": "$datee",
                "time": "$timee",
                "listName": "$listName",
                "listColor": listColor,
                "isDated": isDated,
                "isDone": false,
              });
              for (var index = 0; index < lists.length - 1; index += 1) {
                if (lists[index]["listName"] == listName) {
                  lists[index]["itemCount"] += 1;
                }
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Container oparations(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.05,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.date_range,
              color: isDateButtonActive ? Colors.blue : Color(0xffD8D8D8),
            ),
            onPressed: () {
              setState(() {
                if (isDateButtonActive == true) {
                  isDateButtonActive = false;
                } else if (isDateButtonActive == false) {
                  isDateButtonActive = true;
                  isScheduleButtonActive = false;
                  isSelectListButtonActive = false;
                  FocusScope.of(context).unfocus();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.access_time,
              color: isScheduleButtonActive ? Colors.blue : Color(0xffD8D8D8),
            ),
            onPressed: () {
              setState(() {
                if (isScheduleButtonActive == true) {
                  isScheduleButtonActive = false;
                } else if (isScheduleButtonActive == false) {
                  isScheduleButtonActive = true;
                  isDateButtonActive = false;
                  isSelectListButtonActive = false;
                  FocusScope.of(context).unfocus();
                }
              });
            },
          ),
          InkWell(
            splashColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () {
              setState(() {
                if (isSelectListButtonActive == true) {
                  isSelectListButtonActive = false;
                } else if (isSelectListButtonActive == false) {
                  isSelectListButtonActive = true;
                  isDateButtonActive = false;
                  isScheduleButtonActive = false;
                  FocusScope.of(context).unfocus();
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: size.width * 0.5),
              child: Row(
                children: <Widget>[
                  Container(
                    height: size.height * 0.03,
                    width: size.width * 0.2,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "${selectedListCustoms[0]}",
                        style: TextStyle(color: Color(0xffD8D8D8)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width * 0.03),
                    child: SizedBox(
                      height: 13,
                      width: 13,
                      child: RaisedButton(
                        color: Colors.black,
                        onPressed: null,
                        disabledColor: selectedListCustoms[1],
                        shape: CircleBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container taskPreview(Size size) {
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.only(left: size.width * 0.015),
      height: size.height * 0.15,
      width: size.width,
      child: Container(
        height: size.height * 0.15,
        width: size.width,
        child: Row(
          children: <Widget>[
            Checkbox(onChanged: null, value: false),
            Container(
              padding: EdgeInsets.only(
                  top: datee == null && timee == null
                      ? size.height * 0.05
                      : size.height * 0.04),
              //color: Colors.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.05,
                    child: Container(
                      //color: Colors.green,
                      padding: EdgeInsets.only(top: 2),
                      child: TextField(
                        onChanged: (name) {
                          setState(() {
                            taskName = name;
                          });
                        },
                        onTap: () {
                          setState(() {
                            isScheduleButtonActive = false;
                            isDateButtonActive = false;
                            isSelectListButtonActive = false;
                          });
                        },
                        autofocus: true,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none),
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        enableSuggestions: false,
                        maxLength: 30,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to do?',
                          hintStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.blue,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              datee != null
                                  ? Icon(
                                      Icons.date_range,
                                      color: Colors.grey,
                                      size: 17,
                                    )
                                  : Container(),
                              datee != null
                                  ? Text(
                                      " $datee",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: size.width * 0.015),
                          child: Row(
                            children: <Widget>[
                              timee != null
                                  ? Image(
                                      image: AssetImage(
                                          "assets/img/clock_disabled.png"),
                                    )
                                  : Container(),
                              timee != null
                                  ? Text(
                                      "$timee",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: size.width * 0.12),
              child: SizedBox(
                height: 13,
                width: 13,
                child: RaisedButton(
                  onPressed: null,
                  disabledColor: selectedListCustoms[1],
                  shape: CircleBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

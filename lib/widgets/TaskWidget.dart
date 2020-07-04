import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool checkboxvalue = false;

  final String taskName;
  final bool isScheduled;
  final String time;
  final Color listColor;

  _TaskWidgetState(
      {this.taskName = "Taskname",
      this.isScheduled = true,
      this.time = " 00:00",
      this.listColor = Colors.red});

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
            value: checkboxvalue,
            onChanged: (bool value) {
              print(value);
              setState(() {
                checkboxvalue = value;
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
                        Text(
                          "$taskName",
                          style: TextStyle(
                              color:
                                  (!checkboxvalue) ? Colors.black : Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        isScheduled
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image(
                                    image: (!checkboxvalue)
                                        ? AssetImage(
                                            "assets/img/clock_enabled.png")
                                        : AssetImage(
                                            "assets/img/clock_disabled.png"),
                                  ),
                                  Text(
                                    "$time",
                                    style: TextStyle(
                                        color: (!checkboxvalue)
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
                    margin: EdgeInsets.only(left: size.width * 0.52),
                    child: SizedBox(
                      height: 13,
                      width: 13,
                      child: RaisedButton(
                        color: listColor,
                        onPressed: null,
                        disabledColor: Colors.red,
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

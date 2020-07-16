import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/tasks.dart';
import 'widgets/ListWidgetOnCreateTaskScreen.dart';
import 'package:intl/intl.dart';
import 'package:ToDoApp/utils/Database.dart';

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
  String listName = "Select List";
  Color listColor = Colors.black;
  bool isScheduled = false;
  bool isDated = false;
  bool isDone = false;

  // LİSTE BUTONLARINI SEÇTİĞİMZDE ONLARIN İSMİNİN VE RENGİNİN YAZDIRILMASI İÇİN
  callback(newselectedListCustoms) {
    setState(() {
      selectedListCustoms = newselectedListCustoms;
      listName = newselectedListCustoms[0];
      listColor = newselectedListCustoms[1];
    });
  }

  List<Map<String, dynamic>> allListsList;
  Future listFuture;

  @override
  void initState() {
    super.initState();
    listFuture = getLists();
  }

  getLists() async {
    final _listData = await DBProvider.db.getLists();
    return _listData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // EN ÜSTTEKİ  DONE VE CANCEL BUTONUNUN OLDUĞU BAR
            topArea(size),
            // OLUŞTURULACAK OLAN TASKIN ÖNGÖSTERİMİNİN OLDUĞU WİDGET
            taskPreview(size),
            // ARADAKİ BOŞLUĞU SAĞLAMAK İÇİN SİZEBOX
            SizedBox(
              height: isDateButtonActive |
                      isScheduleButtonActive |
                      isSelectListButtonActive
                  ? size.height * 0.32
                  : size.height * 0.68 -
                      MediaQuery.of(context).viewInsets.bottom,
            ),
            Divider(),
            //  TASK İÇİN SEÇİLECEK ŞEYLERİ AYARLAMAMIZI SAĞLAYAN BUTONLARIN OLDUĞU BAR
            oparations(size, context),

            // TASK İÇİN TARİH SEÇME YERİ

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

            // TASK İÇİN SAAT SEÇME YERİ

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

            // TASK İÇİN LİSTE SEÇME YERİ

            isSelectListButtonActive
                ? Container(
                    height: size.height * 0.34,
                    child: FutureBuilder(
                      future: listFuture,
                      builder: (BuildContext context, _listData) {
                        switch (_listData.connectionState) {
                          case ConnectionState.none:
                            return Container();
                          case ConnectionState.waiting:
                            return Container();
                          case ConnectionState.active:
                            return Container();
                          case ConnectionState.done:
                            if (_listData.data != null) {
                              allListsList = List<Map<String, dynamic>>.from(
                                  _listData.data);
                              return ListView.builder(
                                itemCount: allListsList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ListWidgetOnCreateScreen(
                                      allListsList[index]["listName"],
                                      allListsList[index]["listColor"],
                                      allListsList[index]["itemCount"],
                                      allListsList[index]
                                          ["isSelectedOnCreateScreen"],
                                      callback);
                                },
                              );
                            } else {
                              return Container();
                            }
                        }
                        return Container();
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  // EN ÜSTTEKİ  DONE VE CANCEL BUTONUNUN OLDUĞU BAR

  Container topArea(Size size) {
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.05),
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
              color: Colors.white,
              elevation: 0,
              child: Text(
                "Cancel",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              }),
          SizedBox(
            width: size.width * 0.53,
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
              // TASKI EKLEME , LİSTEDEKİ ITEM SAYISINI ARTTIRMA VE TÜM LİSTELERİ TEKRARDAN DEFAULT OLARAK SEÇİLMEMİŞ YAPMA
              if (taskName == null) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("You must define a name for task."),
                        titleTextStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        elevation: 10,
                      );
                    });
              } else if (datee == null) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("You must define date for task."),
                        titleTextStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        elevation: 10,
                      );
                    });
              } else if (listName == "Select List") {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text("You must define a list for task."),
                        titleTextStyle:
                            TextStyle(fontSize: 20, color: Colors.black),
                        elevation: 10,
                      );
                    });
              } else {
                var newTask = Task(taskName, isDated, isScheduled, datee, timee,
                    listName, listColor.toString(), isDone);
                DBProvider.db.addNewTask(newTask);
                DBProvider.db.increaseItemCount(listName);
                DBProvider.db.reFalseAllList();

                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              }
            },
          )
        ],
      ),
    );
  }

//  TASK İÇİN SEÇİLECEK ŞEYLERİ AYARLAMAMIZI SAĞLAYAN BUTONLARIN OLDUĞU BAR

  Container oparations(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.05,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
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
          ),
          Expanded(
            flex: 1,
            child: IconButton(
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
          ),
          Expanded(
            flex: 8,
            child: InkWell(
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
                padding: EdgeInsets.only(right: size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: size.height * 0.03,
                      width: size.width * 0.2,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "$listName",
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
                          color: listColor,
                          onPressed: null,
                          disabledColor: listColor,
                          shape: CircleBorder(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // OLUŞTURULACAK OLAN TASKIN ÖNGÖSTERİMİNİN OLDUĞU WİDGET

  Container taskPreview(Size size) {
    return Container(
      padding: EdgeInsets.only(left: size.width * 0.015),
      height: size.height * 0.15,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(child: Checkbox(onChanged: null, value: false))),
          Expanded(
            flex: 8,
            child: Container(
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
                        maxLength: 25,
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
          ),
          Expanded(
            flex: 2,
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}

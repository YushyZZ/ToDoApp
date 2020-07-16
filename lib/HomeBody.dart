import 'package:flutter/material.dart';
import './widgets/TaskWidget.dart';
import './widgets/ListWidget.dart';
import 'package:ToDoApp/utils/Database.dart';

class ToDoAppHomeBody extends StatefulWidget {
  Future funcType;
  ToDoAppHomeBody(this.funcType);

  @override
  _ToDoAppHomeBodyState createState() => _ToDoAppHomeBodyState();
}

class _ToDoAppHomeBodyState extends State<ToDoAppHomeBody> {
  List<Map<String, dynamic>> allTasksList;
  List<Map<String, dynamic>> allListsList;
  Future taskFuture;
  Future listFuture;

  void getData() {
    taskFuture = getTasks();
    listFuture = getLists();
  }

  getTasks() async {
    final _taskData = await widget.funcType;
    return _taskData;
  }

  getLists() async {
    final _listData = await DBProvider.db.getLists();
    return _listData;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getData();

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: size.height * 0.33,
            child: FutureBuilder(
              future: taskFuture,
              builder: (BuildContext context, _taskData) {
                switch (_taskData.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.waiting:
                    return Container();
                  case ConnectionState.active:
                    return Container();
                  case ConnectionState.done:
                    if (_taskData.data != null) {
                      allTasksList =
                          List<Map<String, dynamic>>.from(_taskData.data);

                      return ListView.builder(
                          itemCount: allTasksList.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return TaskWidget(
                                allTasksList[index]["taskName"],
                                allTasksList[index]["isScheduled"],
                                allTasksList[index]["time"],
                                allTasksList[index]["listColor"],
                                allTasksList[index]["isDone"]);
                          });
                    } else {
                      return Container(
                        
                        child: Text("There isn't any task at this time yet.",style: TextStyle(color: Colors.grey),),
                        padding: EdgeInsets.only(top: size.height*0.13),
                      );
                    }
                }
                return Container();
              },
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
                            allListsList =
                                List<Map<String, dynamic>>.from(_listData.data);

                            return ListView.builder(
                                itemCount: allListsList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return ListWidget(
                                    allListsList[index]["listName"],
                                    allListsList[index]["listColor"],
                                    allListsList[index]["itemCount"],
                                  );
                                });
                          } else {
                            return Container();
                          }
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

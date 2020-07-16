import 'package:ToDoApp/widgets/TaskWidgetonListPage.dart';
import 'package:flutter/material.dart';
import 'package:ToDoApp/utils/Database.dart';

// ignore: must_be_immutable
class ListPage extends StatefulWidget {
  final Size size;
  final Color listColor;
  final String listName;
  final int itemCount;

  ListPage(this.size, this.listColor, this.listName, this.itemCount);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Map<String, dynamic>> allTasksofList;

  Future tasksofListFuture;

  void initState() {
    super.initState();
    tasksofListFuture = getTasks();
  }

  getTasks() async {
    final _taskofListData =
        await DBProvider.db.getTasksOfspecificList(widget.listName);
    return _taskofListData;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          height: widget.size.height * 0.97,
          color: Colors.transparent,
          child: new Container(
            decoration: new BoxDecoration(
              color: widget.listColor,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: widget.size.width,
                  height: widget.size.height * 0.15,
                  margin: EdgeInsets.only(top: 20),
                  padding:
                      EdgeInsets.only(left: 30, right: 5, top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                       
                        padding: EdgeInsets.symmetric(horizontal: widget.size.width*0.055),
                        height: widget.size.height * 0.06,                       
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "${widget.listName}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: widget.size.width*0.055),
                        height: widget.size.height * 0.03,
                        width: widget.size.width * 0.7,
                        child: Text("${widget.itemCount} tasks",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: widget.size.height * 0.775,
                  width: widget.size.width * 1,
                  child: FutureBuilder(
                    future: tasksofListFuture,
                    builder: (BuildContext context, _taskofListData) {
                      switch (_taskofListData.connectionState) {
                        case ConnectionState.none:
                          return Text("none");
                        case ConnectionState.waiting:
                          return Text("waiting");
                        case ConnectionState.active:
                          return Text("active");
                        case ConnectionState.done:
                          if (_taskofListData.data != null) {
                            allTasksofList = List<Map<String, dynamic>>.from(
                                _taskofListData.data);

                            return ListView.builder(
                                itemCount: allTasksofList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  return TaskWidgetOnList(
                                    allTasksofList[index]["taskName"],
                                    allTasksofList[index]["isScheduled"],
                                    allTasksofList[index]["time"],
                                    allTasksofList[index]["listColor"],
                                    allTasksofList[index]["isDated"],
                                    allTasksofList[index]["date"],
                                    allTasksofList[index]["isDone"],
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
          ),
        ),
      ],
    );
  }
}

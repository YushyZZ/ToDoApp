import 'package:flutter/material.dart';
import '../models/lists.dart';

class ListWidgetOnCreateScreen extends StatefulWidget {
  final String listName;
  final Color listColor;
  final int itemCount;
  bool isSelectedOnCreateScreen;
  Function(List) callback;

  ListWidgetOnCreateScreen(this.listName, this.listColor, this.itemCount,
      this.isSelectedOnCreateScreen, this.callback);

  @override
  _ListWidgetOnCreateScreenState createState() =>
      _ListWidgetOnCreateScreenState(
          listName, listColor, itemCount, isSelectedOnCreateScreen, callback);
}

class _ListWidgetOnCreateScreenState extends State<ListWidgetOnCreateScreen> {
  final String listName;
  final Color listColor;
  final int itemCount;
  bool isSelectedOnCreateScreen;
  Function(List) callback;

  _ListWidgetOnCreateScreenState(this.listName, this.listColor, this.itemCount,
      this.isSelectedOnCreateScreen, this.callback);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        for (var index = 0; index <= lists.length - 1; index += 1) {
          if (lists[index]["listName"] == listName) {
            setState(() {
              if (lists[index]["isSelectedOnCreateScreen"] == true) {
                lists[index]["isSelectedOnCreateScreen"] = false;

                callback(["List Name", Colors.black]);
              } else if (lists[index]["isSelectedOnCreateScreen"] == false) {
                lists[index]["isSelectedOnCreateScreen"] = true;

                callback([lists[index]["listName"], lists[index]["listColor"]]);
              }
            });
          }
        }
        
      },
      child: Container(
        decoration: BoxDecoration(
            color: listColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        height: size.height * 0.085,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Container(
          width: size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "$listName",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "${itemCount.toString()} tasks",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

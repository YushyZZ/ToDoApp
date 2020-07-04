import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final String listName;
  final Color listColor;
  final int itemCount;

  _ListWidgetState(
      {this.listName = "List Name",
      this.listColor = Colors.blue,
      this.itemCount = 2});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            color: listColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        height: size.height * 0.085,
        margin: EdgeInsets.only(left: 45, top: 10, right: 10),
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
                "$itemCount tasks",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

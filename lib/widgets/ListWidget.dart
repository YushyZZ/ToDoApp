import 'package:ToDoApp/widgets/TaskWidgetonListScreen.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatefulWidget {
  final String listName;
  final Color listColor;
  final int itemCount;

  ListWidget(
      this.listName,
      this.listColor,
      this.itemCount);

  @override
  _ListWidgetState createState() => _ListWidgetState(listName,listColor,itemCount);
}

class _ListWidgetState extends State<ListWidget> {
  final String listName;
  final Color listColor;
  final int itemCount;

  _ListWidgetState(
      this.listName,
      this.listColor,
      this.itemCount);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _modalBottomSheetMenu(context, size, listColor, listName, itemCount);
      },
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
                "${itemCount.toString()} tasks",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _modalBottomSheetMenu(context, size, listColor, listName, itemCount) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return Wrap(
        children: <Widget>[
          Container(
            height: size.height * 0.95,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              decoration: new BoxDecoration(
                color: listColor,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: size.height * 0.15,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                        left: 30, right: 5, top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              height: size.height * 0.06,
                              width: size.width * 0.7,
                              child: Text(
                                "$listName",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              height: size.height * 0.03,
                              width: size.width * 0.7,
                              child: Text("$itemCount tasks",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: size.height * 0.04,
                              left: size.width * 0.09),
                          child: InkWell(
                            child: Image.asset(
                              "assets/img/Edit.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.775,
                    width: size.width * 1,
                    child: ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new TaskWidgetOnList();
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

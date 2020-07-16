import 'package:ToDoApp/utils/Database.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ListWidgetOnCreateScreen extends StatefulWidget {
  final String listName;
  final String listColor;
  final int itemCount;
  int isSelectedOnCreateScreen;
  Function(List) callback;

  ListWidgetOnCreateScreen(this.listName, this.listColor, this.itemCount,
      this.isSelectedOnCreateScreen, this.callback);

  @override
  _ListWidgetOnCreateScreenState createState() =>
      _ListWidgetOnCreateScreenState();
}

class _ListWidgetOnCreateScreenState extends State<ListWidgetOnCreateScreen> {

  bool realisSelectedOnCreateScreen;
  Color realColor;


  void initState() {
    intToBool();
    stringToColor();
    super.initState();
  }

  void intToBool() {
    if (widget.isSelectedOnCreateScreen == 1) {
      realisSelectedOnCreateScreen = true;
    } else if (widget.isSelectedOnCreateScreen == 0) {
      realisSelectedOnCreateScreen = false;
    }
  }

  void stringToColor() {
    if (widget.listColor == "Color(0xff22a1d4)") {
      realColor = Color(0xff22a1d4);
    }
    else if (widget.listColor == "Color(0xfff29a0c)") {
      realColor =  Color(0xfff29a0c);
    }
    else if (widget.listColor == "Color(0xffe7f20c)") {
      realColor =  Color(0xffe7f20c);
    }
    else if (widget.listColor == "Color(0xffc92a9c)") {
      realColor =  Color(0xffc92a9c);
    }
    else if (widget.listColor == "Color(0xff050505)") {
      realColor =  Color(0xff050505);
    }
    else if (widget.listColor == "Color(0xff20c723)") {
      realColor =  Color(0xff20c723);
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        DBProvider.db.selectaList(widget.listName);
        widget.callback([widget.listName , realColor]);
        
        
      },
      child: Container(
        decoration: BoxDecoration(
            color: realColor,
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
                  "${widget.listName}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  "${widget.itemCount.toString()} tasks",
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

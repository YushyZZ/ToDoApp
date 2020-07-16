import 'package:flutter/material.dart';
import './ListPage.dart';



class ListWidget extends StatefulWidget {
  final String listName;
  final String listColor;
  final int itemCount;

  ListWidget(
      this.listName,
      this.listColor,
      this.itemCount);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  
  Color realColor;

  
  void initState() {
    stringToColor();
    super.initState();
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
        _listmodalBottomSheetMenu(context, size, realColor, widget.listName, widget.itemCount);
      },
      child: Container(
        decoration: BoxDecoration(
            color: realColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        height: size.height * 0.085,
        margin: EdgeInsets.only(left: 45, top: 10, right: 10),
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
    );
  }
}

void _listmodalBottomSheetMenu(context, size, realColor, listName, itemCount) {
  showModalBottomSheet(
    
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return ListPage(size,realColor,listName,itemCount);
    },
  );
}


import 'package:flutter/material.dart';
import './ListPage.dart';



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
        _listmodalBottomSheetMenu(context, size, listColor, listName, itemCount);
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

void _listmodalBottomSheetMenu(context, size, listColor, listName, itemCount) {
  showModalBottomSheet(
    
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    isScrollControlled: true,
    context: context,
    builder: (builder) {
      return ListPage(size,listColor,listName,itemCount);
    },
  );
}


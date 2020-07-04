import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
          margin: EdgeInsets.only(left: size.width * 0.08 ),
          child: Text(
            "Today",
            style: TextStyle(
                fontSize: 41, color: Colors.black, fontWeight: FontWeight.bold),
          )),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_horiz),
          onPressed: () {},
          color: Colors.blue,
          iconSize: 30,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class Appbar extends StatefulWidget {
  
  final Size size;
  Function(List) callback;

  Appbar(this.size , this.callback);
 

  @override
  _AppbarState createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {

  String showingTime = "Today";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
          margin: EdgeInsets.only(left: widget.size.width * 0.08 ),   
          child: Text(
            showingTime,
            style: TextStyle(
                fontSize: 41, color: Colors.black, fontWeight: FontWeight.bold),
          )),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        PopupMenuButton<String>(
          icon: Icon(Icons.more_horiz , color: Colors.blue,),
          onSelected: (value) {
            setState(() {
            widget.callback([value]);
            showingTime = value;
          });},
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(value: "Today",child: Text("Today"),),
            PopupMenuItem<String>(value: "Tomorrow",child: Text("Tomorrow"),),
            PopupMenuItem<String>(value: "This Week",child: Text("This Week"),),
            PopupMenuItem<String>(value: "Further",child: Text("Further"),),
           ] ,
          
        
          
        )
      ],
    );
  }
}

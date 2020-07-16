import 'package:ToDoApp/CreateTaskScreen.dart';
import 'package:flutter/material.dart';
import 'Appbar.dart';
import 'HomeBody.dart';
import 'package:ToDoApp/utils/Database.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoAppHome(),
      routes: {
        "": (context) => ToDoAppHomeBody(DBProvider.db.getTasksOfToday()),
        "/createtaskscreen": (context) => CreateTaskScreen()
      },
    );
  }
}

class ToDoAppHome extends StatefulWidget {
  @override
  _ToDoAppHomeState createState() => _ToDoAppHomeState();
}

class _ToDoAppHomeState extends State<ToDoAppHome> {
  
  Future type = DBProvider.db.getTasksOfToday();
  String showingTimee;


  callback(showingTime) {
    setState(
      () {
        showingTimee = showingTime[0]; 
        if (showingTimee == "Today") {type = DBProvider.db.getTasksOfToday();}  
        else if (showingTimee == "Tomorrow") {type = DBProvider.db.getTasksOfTomorrow();} 
        else if (showingTimee == "This Week") {type = DBProvider.db.getTasksOfThisWeek();}    
        else if (showingTimee == "Further") {type = DBProvider.db.getTasksOfFurther();}   
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: Appbar(size, callback),
        preferredSize: Size(size.width, size.height * 0.09),
      ),
      backgroundColor: Colors.white,
      body: ToDoAppHomeBody(type),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pop(context);
            Navigator.of(context).pushNamed("/createtaskscreen");
          });
        },
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/img/plus.png",
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';



class CreateTaskListMenu extends StatelessWidget {
  const CreateTaskListMenu({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: Offset(0, 5),
            ),
          ]),
      height: size.height * 0.14,
      width: size.width * 0.5,
      margin: EdgeInsets.only(top: size.height * 0.64, left: size.width * 0.47),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("/createtaskscreen");
            },
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 52,
              child: Row(
                children: <Widget>[
                  Image.asset("assets/img/Tasks.png"),
                  const Text(
                    " Task",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50.08,
              child: Row(
                children: <Widget>[
                  Image.asset("assets/img/Lists.png"),
                  const Text(" List",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 15))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}



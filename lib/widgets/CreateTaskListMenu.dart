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
            borderRadius: BorderRadius.circular(10)),
        height: size.height * 0.14,
        width: size.width * 0.5,
        margin: EdgeInsets.only(
            top: size.height * 0.64, left: size.width * 0.47),
      );
  }
}


import 'package:flutter/material.dart';
import 'HomeBody.dart';

class AbsorbedHome extends StatelessWidget {
  const AbsorbedHome({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
        child: Stack(
          children: <Widget>[
            ToDoAppHomeBody(),
            Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.white,
                height: size.height * 0.88,
              ),
            )
          ],
        ),
      );
  }
}

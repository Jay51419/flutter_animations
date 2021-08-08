import 'package:flutter/material.dart';

const double radius = 20;

class Cursor extends StatelessWidget {
  final Offset offset;
  const Cursor({Key key, @required this.offset}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Transform.translate(
        offset: offset,
        child: Container(
          height: radius * 2,
          width: radius * 2,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}

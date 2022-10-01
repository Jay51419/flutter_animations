import 'package:flutter/material.dart';

const double radius = 45;

class ReflectlyColor extends StatelessWidget {
  final Color color;
  const ReflectlyColor({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
          border: Border.all(color: Colors.white, width: 5),
        ),
      ),
    );
  }
}

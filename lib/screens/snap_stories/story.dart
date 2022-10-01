import 'dart:math';

import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  final Color color;
  const Story({Key key, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.network(
          "https://picsum.photos/1080/1920}",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

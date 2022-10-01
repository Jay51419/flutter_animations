import 'package:flutter/material.dart';

var margin = 20;
double radius = 20;

class Movie extends StatelessWidget {
  final String image;
  final double width;
  const Movie({
    Key key,
    @required this.image,
    @required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Align(
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: radius),
              borderRadius: BorderRadius.circular(radius)),
          child: Container(
            height: 0.4 * size.height,
            width: width,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.black45,
            ),
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

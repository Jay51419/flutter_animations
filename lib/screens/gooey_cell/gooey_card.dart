import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';

const double cardHeight = 80;

class GooeyCard extends StatelessWidget {
  final double x;
  const GooeyCard({
    Key key,
    this.x,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Transform.translate(
      offset: Offset(x, 0),
      child: Opacity(
        opacity: Interpolate(
          inputRange: [0, size.width],
          outputRange: [1, 0],
        ).eval(x),
        child: Container(
          height: cardHeight,
          width: size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.train, color: Colors.teal[800]),
                      SizedBox(width: 10),
                      Text(
                        "Trip Advisor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "You saved search to veina",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    "There's everything that can be...",
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              Text(
                "22 Feb",
                style: TextStyle(
                  color: Colors.teal[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

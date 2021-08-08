import 'dart:math';
import 'dart:ui';

import 'package:fluttanim/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

const double cardHeight = 80;

class GooeyCell extends HookWidget {
  const GooeyCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var x = useState(0.0);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Container(
            height: cardHeight,
            width: size.width,
            child: Stack(
              children: [
                CustomPaint(
                  size: size,
                  painter: GooeyPainter(
                      x: x.value,
                      progress: Interpolate(
                        inputRange: [size.width / 6, size.width / 2],
                        outputRange: [0, 1],
                        extrapolate: Extrapolate.clamp,
                      ).eval(x.value)),
                ),
                GestureDetector(
                  onPanUpdate: (details) {
                    x.value =
                        clamp(details.delta.dx + x.value, 0, size.width * 0.6);
                  },
                  onPanEnd: (details) {
                    // x.value = 0;
                  },
                  child: Card(x: x.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  final double x;
  const Card({
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

class GooeyPainter extends CustomPainter {
  final double progress;
  final double x;

  GooeyPainter({this.progress, this.x});
  num degToRad(num deg) => deg * (pi / 180.0);
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Path circlePath = Path();
    Paint paint = Paint()..color = Colors.teal[800];
    double radius = Interpolate(
            inputRange: [0, 0.5, 1],
            outputRange: [0, 15, 20],
            extrapolate: Extrapolate.clamp)
        .eval(progress);
    var factor = {
      "x": lerpDouble(0, 2.5, progress),
      "y": lerpDouble(0, 0.4, progress),
    };
    path.lineTo(0, cardHeight);
    path.cubicTo(0, cardHeight, 0, cardHeight * (1 - factor["y"]),
        20 * progress, cardHeight * (1 - factor["y"]));
    path.cubicTo(
        25 * progress * 2,
        cardHeight * (1 - factor["y"]) - 2,
        25 * progress * 2,
        cardHeight * factor["y"] + 2,
        20 * progress,
        cardHeight * factor["y"]);
    // path.quadraticBezierTo(
    //     70 * progress, cardHeight / 2, 50 * progress, cardHeight * factor["y"]);
    // path.lineTo(50 * progress, cardHeight * factor["y"]);
    path.cubicTo(0, cardHeight * factor["y"], 0, 0, 0, 0);
    canvas.drawPath(path, paint);
    canvas.drawCircle(
        Offset(
            Interpolate(
                    inputRange: [0, 0.5, 1],
                    outputRange: [-10, 0, 50],
                    extrapolate: Extrapolate.clamp)
                .eval(progress),
            cardHeight / 2),
        3,
        paint);
    canvas.drawCircle(
        Offset(
            Interpolate(
                    inputRange: [0, 0.5, 1],
                    outputRange: [0, 0.5, 100],
                    extrapolate: Extrapolate.clamp)
                .eval(progress),
            cardHeight / 2),
        radius,
        paint);
    circlePath.moveTo(
        Interpolate(
                inputRange: [0, 0.5, 1],
                outputRange: [0, 0.5, 100],
                extrapolate: Extrapolate.clamp)
            .eval(progress),
        cardHeight / 2 -
            Interpolate(
                    inputRange: [0, 0.5, 1],
                    outputRange: [0, 15, 20],
                    extrapolate: Extrapolate.clamp)
                .eval(progress));
    circlePath.cubicTo(
        Interpolate(inputRange: [0, 0.4, 1], outputRange: [0, -40, 50])
            .eval(progress),
        Interpolate(
            inputRange: [0, 1],
            outputRange: [cardHeight * 0.2, cardHeight * 0.3]).eval(progress),
        Interpolate(inputRange: [0, 0.4, 1], outputRange: [0, -40, 50])
            .eval(progress),
        Interpolate(
            inputRange: [0, 1],
            outputRange: [cardHeight * 0.8, cardHeight * 0.7]).eval(progress),
        Interpolate(
                inputRange: [0, 0.5, 1],
                outputRange: [0, 0.5, 100],
                extrapolate: Extrapolate.clamp)
            .eval(progress),
        cardHeight / 2 +
            Interpolate(
                    inputRange: [0, 0.5, 1],
                    outputRange: [0, 15, 20],
                    extrapolate: Extrapolate.clamp)
                .eval(progress));
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(GooeyPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GooeyPainter oldDelegate) => false;
}

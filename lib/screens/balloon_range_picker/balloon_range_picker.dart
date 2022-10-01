import 'dart:math';

import 'package:animated/animated.dart';
import 'package:fluttanim/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class BalloonRangePicker extends HookWidget {
  const BalloonRangePicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cursorX = useState(0.0);
    var balloonX = useState(0.0);
    var angleX = useState(0.0);
    var isGestureActive = useState(false);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Center(
          child: Container(
            height: 100,
            width: size.width * 0.8,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Container(
                height: 2,
                width: size.width * 0.8,
                color: Colors.grey[400],
              ),
              GestureDetector(
                onPanStart: (details) {
                  isGestureActive.value = true;
                },
                onPanUpdate: (details) {
                  cursorX.value = clamp(cursorX.value + details.delta.dx, 0,
                      size.width * 0.8 - cursorRadius * 2);
                  balloonX.value = cursorX.value + cursorRadius;
                  var time =
                      ((balloonX.value - angleX.value) / 2).abs().toInt() * 100;
                  Future.delayed(Duration(milliseconds: 100), () {
                    angleX.value = balloonX.value;
                  });
                },
                onPanEnd: (details) {
                  isGestureActive.value = false;
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Cursor(
                    borderWidth: isGestureActive.value ? 2 : 6,
                    x: cursorX.value,
                  ),
                ),
              ),
              Animated(
                duration: Duration(milliseconds: 300),
                value: angleX.value == balloonX.value
                    ? 0
                    : angleX.value < balloonX.value
                        ? pi / -5
                        : pi / 5,
                builder: (ctx, child, value) {
                  return Transform.rotate(
                    origin: Offset(angleX.value, 0),
                    angle: value.value,
                    child: child,
                  );
                },
                child: Animated(
                  duration: Duration(milliseconds: 200),
                  value: isGestureActive.value ? -cursorRadius * 4 : 0,
                  builder: (ctx, child, value) {
                    var scale = Interpolate(
                      inputRange: [-cursorRadius * 4, 0],
                      outputRange: [1, 0],
                    ).eval(value.value);
                    return Transform.scale(
                      origin: Offset(balloonX.value, -cursorRadius * 1.5),
                      scale: scale,
                      child: Transform.translate(
                          offset: Offset(balloonX.value, value.value),
                          child: child),
                    );
                  },
                  child: CustomPaint(
                    painter: BalloonPainter(),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

const double cursorRadius = 10;
const double cursorSize = cursorRadius * 2;

class Cursor extends StatelessWidget {
  final double borderWidth;
  final double x;
  const Cursor({Key key, @required this.borderWidth, @required this.x})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(x, 50 - cursorRadius),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: cursorSize,
        width: cursorSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cursorRadius),
          border: Border.all(color: Colors.amber, width: borderWidth),
        ),
      ),
    );
  }
}

class BalloonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Path curvePath = Path();
    Path conicPath = Path();
    Paint paint = Paint()..color = Colors.amber;
    path.moveTo(0, 0);
    path.addOval(Rect.fromCircle(center: Offset(0, 0), radius: 15));

    canvas.drawPath(path, paint);
    curvePath.moveTo(-15, 0);
    curvePath.quadraticBezierTo(0, 40, 15, 0);
    canvas.drawPath(curvePath, paint);
    conicPath.moveTo(-5, cursorRadius * 2.5);
    conicPath.quadraticBezierTo(0, 14, 5, cursorRadius * 2.5);
    canvas.drawPath(conicPath, paint);
  }

  @override
  bool shouldRepaint(BalloonPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BalloonPainter oldDelegate) => false;
}

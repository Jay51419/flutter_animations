import 'dart:math';
import 'dart:ui';

import 'package:fluttanim/screens/gooey_cell/gooey_card.dart';
import 'package:fluttanim/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class GooeyCell extends HookWidget {
  const GooeyCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var x = useState(0.0);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: SizedBox(
            height: cardHeight,
            width: size.width,
            child: Stack(
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.matrix([
                    1,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                    0,
                    0,
                    0,
                    0,
                    18,
                    -7.0 * 255
                  ]),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal),
                    child: Transform.translate(
                      offset: Offset(
                          Interpolate(
                            inputRange: [0, size.width * 0.3],
                            outputRange: [-150, 0],
                            extrapolate: Extrapolate.clamp,
                          ).eval(x.value),
                          0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: CustomPaint(
                              size: size,
                              painter: GooeyPainter(
                                x: x.value,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(
                                Interpolate(inputRange: [
                                  size.width * 0.2,
                                  size.width * 0.8
                                ], outputRange: [
                                  0,
                                  50 * 2.0
                                ], extrapolate: Extrapolate.clamp)
                                    .eval(x.value),
                                0),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal[800],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text("Hello"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                    offset: Offset(
                        Interpolate(inputRange: [
                          size.width * 0.3,
                          size.width * 0.7
                        ], outputRange: [
                          size.width * 0.2,
                          size.width * 0.2 + 90,
                        ], extrapolate: Extrapolate.clamp)
                            .eval(x.value),
                        25),
                    child: Opacity(
                        opacity: Interpolate(inputRange: [
                          size.width * 0.3,
                          size.width * 0.7
                        ], outputRange: [
                          0,
                          1,
                        ], extrapolate: Extrapolate.clamp)
                            .eval(x.value),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ))),
                GestureDetector(
                  onPanUpdate: (details) {
                    x.value =
                        clamp(details.delta.dx + x.value, 0, size.width * 0.6);
                    print(x.value);
                  },
                  onPanEnd: (details) {
                    x.value = 0;
                  },
                  child: GooeyCard(x: x.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GooeyPainter extends CustomPainter {
  final double x;

  GooeyPainter({this.x});
  num degToRad(num deg) => deg * (pi / 180.0);
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()..color = Colors.teal[800];
    double width = 100;
    path.moveTo(-20, -50);
    path.quadraticBezierTo(width / 2, 30, width, cardHeight / 2.5);
    path.quadraticBezierTo(width + 30, cardHeight / 2.5, width, cardHeight / 2);
    path.quadraticBezierTo(width / 2, cardHeight / 2, -20, cardHeight + 50);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(GooeyPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(GooeyPainter oldDelegate) => false;
}

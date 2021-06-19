import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class Graph extends HookWidget {
  const Graph({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double x = size.width;
    double y = size.height / 2;
    double x1 = x / 4;
    double y1 = y - radius;
    double x2 = x / 2;
    double y2 = y;
    ValueNotifier<Offset> cursorOffset = useState(Offset(0, y - radius * 2));
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.amber,
        child: Stack(
          children: [
            CustomPaint(
              size: size,
              painter: CurvePainter(
                x: x,
                y: y,
                x1: x1,
                y1: y1,
                x2: x2,
                y2: y2,
              ),
            ),
            Container(
              height: size.height,
              width: size.width,
              child: GestureDetector(
                onPanUpdate: (details) {
                  double dx = cursorOffset.value.dx + details.delta.dx;
                  double dy = Interpolate(
                    inputRange: [
                      0,
                      size.width / 4,
                      size.width / 2,
                      size.width / 1.2,
                      size.width
                    ],
                    outputRange: [
                      (size.height / 2) - radius * 1.5,
                      (size.height / 2 - radius * 2),
                      (size.height / 2) - radius,
                      (size.height / 2) + 8,
                      (size.height / 2) - radius,
                    ],
                    extrapolate: Extrapolate.clamp,
                  ).eval(dx);
                  print([
                    (size.height / 2) - radius * 1.5,
                    (size.height / 2 - radius * 2),
                    (size.height / 2) - radius,
                    (size.height / 2) - 8,
                    (size.height / 2) - radius * 1.5,
                  ]);
                  cursorOffset.value = Offset(dx, dy);
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Transform.translate(
                    offset: cursorOffset.value,
                    child: Cursor(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double x;
  final double x1;
  final double y;
  final double y1;
  final double x2;
  final double y2;
  CurvePainter({this.x, this.x1, this.y, this.y1, this.x2, this.y2});

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height / 2;
    double x1 = size.width / 3;
    double y1 = size.height / 3;
    double x2 = 3 * size.width / 5;
    double y2 = 3 * size.height / 5;
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    path.moveTo(0, size.height / 2);
    // path.cubicTo(x1, y1, x2, y2, x, y);
    path.quadraticBezierTo(size.width / 4, size.height / 2 - radius * 2,
        size.width / 2, size.height / 2);
    path.quadraticBezierTo(size.width / 1.2, size.height / 2 + radius * 2,
        size.width, size.height / 2);
    // path.lineTo(size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CurvePainter oldDelegate) => false;
}

const double radius = 15;

class Cursor extends StatelessWidget {
  const Cursor({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.redAccent,
          border: Border.all(color: Colors.white, width: 2.0)),
    );
  }
}

// abstract class Vector {
//   Vector(double x, double y);
//   double get x => x;
//   double get y => y;
// }

//  cubicBezierYForX  (
//    double x,
//    Vector a,
//    Vector b,
//    Vector c,
//    Vector d,
// )  {
//   var precision = 2
//   var pa = -a.x + 3 * b.x - 3 * c.x + d.x;
//   var pb = 3 * a.x - 6 * b.x + 3 * c.x;
//   var pc = -3 * a.x + 3 * b.x;
//   var pd = a.x - x;
//   // eslint-disable-next-line prefer-destructuring
//   const t = solveCubic(pa, pb, pc, pd)
//     .map((root) => round(root, precision))
//     .filter((root) => root >= 0 && root <= 1)[0];
//   return cubicBezier(t, a.y, b.y, c.y, d.y);
// };
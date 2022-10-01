import 'dart:math';

import 'package:fluttanim/screens/circular_slider/cursor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const double stroke = 40;
const double padding = 20;
Offset polar2canvas({theta: double, radius: double, center: double}) {
  return Offset(radius * cos(theta), radius * sin(theta));
}

double canvas2polar({offset: Offset}) {
  return atan2(offset.dy, offset.dx);
}

class CustomSlider extends HookWidget {
  const CustomSlider({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var radius = (size.width / 2) - padding * 2;
    var start = useState(0.0);
    var end = useState(pi);
    return Stack(
      children: [
        Center(
          child: CustomPaint(
            painter: SliderPainter(
              start:
                  polar2canvas(center: 0, radius: radius, theta: start.value),
              end: polar2canvas(center: 0, radius: radius, theta: end.value),
              startAngle: start.value,
              endAngle: end.value,
              radius: radius,
            ),
          ),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            start.value = canvas2polar(
                offset: polar2canvas(
                        center: 0, radius: radius, theta: start.value) +
                    details.delta);
            print(start.value + end.value);
          },
          child: Cursor(
            offset: polar2canvas(center: 0, radius: radius, theta: start.value),
          ),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            end.value = canvas2polar(
                offset:
                    polar2canvas(center: 0, radius: radius, theta: end.value) +
                        details.delta);
            print(start.value + end.value);
          },
          child: Cursor(
            offset: polar2canvas(center: 0, radius: radius, theta: end.value),
          ),
        ),
      ],
    );
  }
}

class SliderPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final double startAngle;
  final double endAngle;
  final double radius;

  SliderPainter(
      {this.start, this.end, this.radius, this.startAngle, this.endAngle});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    Path path = Path();
    path.moveTo(start.dx, start.dy);
    path.arcToPoint(end,
        radius: Radius.circular(radius),
        largeArc: startAngle + endAngle < 0 ? true : false);
    // path.addArc(
    //     Rect.fromLTWH(-radius, -radius, radius * 2, radius * 2), start, end);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SliderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SliderPainter oldDelegate) => false;
}

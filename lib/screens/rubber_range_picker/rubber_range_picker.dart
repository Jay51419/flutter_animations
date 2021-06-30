import 'package:fluttanim/screens/Reflectly/reflectly_color.dart';
import 'package:fluttanim/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

const double containerHeight = 150;
const double cursorRadius = 20;

class RubberRangePicker extends HookWidget {
  const RubberRangePicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isC1Active = useState(false);
    var isC2Active = useState(false);
    var c1 = useState(Offset(0, containerHeight / 2));
    var c2 = useState(Offset(cursorRadius * 2, containerHeight / 2));
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.grey[100],
        child: Center(
          child: Container(
            height: containerHeight,
            width: size.width * 0.8,
            child: Stack(
              children: [
                CustomPaint(
                  size: size,
                  painter: RubberPainter(
                      c1: c1.value, c2: c2.value, color: Colors.grey[400]),
                ),
                ClipRect(
                  clipper: RectClipper(c1.value, c2.value),
                  child: CustomPaint(
                    size: size,
                    painter: RubberPainter(
                        c1: c1.value, c2: c2.value, color: Colors.blue),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: isC1Active.value ? 1 : 0,
                  child: Transform.translate(
                    offset: Offset(
                        clamp(c1.value.dx - (cursorRadius * 4) / 4,
                            -cursorRadius / 2, size.width * 0.8 + cursorRadius),
                        clamp(
                            c1.value.dy - (cursorRadius * 4) / 2,
                            -cursorRadius / 1.5,
                            containerHeight - cursorRadius * 3.8)),
                    child: Container(
                      height: cursorRadius * 4,
                      width: cursorRadius * 4,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            BorderRadius.circular((cursorRadius * 4) / 2),
                        border: Border.all(color: Colors.grey[200], width: 6),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: isC2Active.value ? 1 : 0,
                  child: Transform.translate(
                    offset: Offset(
                        clamp(
                            c2.value.dx - (cursorRadius * 4) / 4,
                            -cursorRadius / 2,
                            (size.width * 0.8) -
                                (size.width * 0.2) +
                                cursorRadius / 2),
                        clamp(
                            c2.value.dy - (cursorRadius * 4) / 2,
                            -cursorRadius / 1.5,
                            containerHeight - cursorRadius * 3.8)),
                    child: Container(
                      height: cursorRadius * 4,
                      width: cursorRadius * 4,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            BorderRadius.circular((cursorRadius * 4) / 2),
                        border: Border.all(color: Colors.grey[200], width: 6),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onPanStart: (details) {
                    isC2Active.value = true;
                  },
                  onPanUpdate: (details) {
                    var dx = clamp(c2.value.dx + details.delta.dx,
                        cursorRadius * 2, size.width * 0.8 - cursorRadius * 2);
                    var dy = clamp(c2.value.dy + details.delta.dy, cursorRadius,
                        containerHeight - cursorRadius);
                    c2.value = Offset(dx, dy);
                    if ((c2.value.dx - c1.value.dx) <= 30) {
                      c1.value = Offset(
                          clamp(c2.value.dx - cursorRadius * 2, 0,
                              size.width * 0.8 - cursorRadius * 2),
                          c1.value.dy);
                    }
                  },
                  onPanEnd: (details) {
                    isC2Active.value = false;
                  },
                  child: Cursor(
                    offset: c2.value,
                    color:
                        isC2Active.value ? Colors.blue[100] : Colors.grey[100],
                  ),
                ),
                GestureDetector(
                  onPanStart: (details) {
                    isC1Active.value = true;
                  },
                  onPanUpdate: (details) {
                    var dx = clamp(c1.value.dx + details.delta.dx, 0,
                        size.width * 0.8 - cursorRadius * 4);
                    var dy = clamp(c1.value.dy + details.delta.dy, cursorRadius,
                        containerHeight - cursorRadius);
                    c1.value = Offset(dx, dy);
                    if (c2.value.dx - c1.value.dx <= 30) {
                      c2.value = Offset(
                          clamp(c1.value.dx + cursorRadius * 2, 0,
                              size.width * 0.8 - cursorRadius * 2),
                          c2.value.dy);
                    }
                  },
                  onPanEnd: (details) {
                    isC1Active.value = false;
                  },
                  child: Cursor(
                    offset: c1.value,
                    color:
                        isC1Active.value ? Colors.blue[100] : Colors.grey[100],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RubberPainter extends CustomPainter {
  final Offset c1;
  final Offset c2;
  final Color color;
  RubberPainter({this.c1, this.c2, this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    path.moveTo(0, containerHeight / 2);
    path.quadraticBezierTo(0, containerHeight / 2, c1.dx + cursorRadius, c1.dy);
    path.quadraticBezierTo(
        (c2.dx + c1.dx) / 2,
        Interpolate(
          inputRange: [0, containerHeight / 2, containerHeight],
          outputRange: [0, containerHeight / 2, containerHeight],
          extrapolate: Extrapolate.clamp,
        ).eval(c1.dy),
        c2.dx + cursorRadius,
        c2.dy);
    path.lineTo(size.width, containerHeight / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(RubberPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(RubberPainter oldDelegate) => false;
}

class Cursor extends StatelessWidget {
  final Offset offset;
  final Color color;

  const Cursor({Key key, this.offset, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset.dx, offset.dy - radius / 2),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          // duration: Duration(milliseconds: 200),
          height: cursorRadius * 2,
          width: cursorRadius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cursorRadius),
            color: color,
            border: Border.all(color: Colors.blue, width: 2.5),
          ),
        ),
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  final Offset offset1;
  final Offset offset2;

  RectClipper(this.offset1, this.offset2);
  @override
  Rect getClip(Size size) {
    return (Rect.fromLTRB(
        offset1.dx + cursorRadius, 0, offset2.dx + cursorRadius, size.height));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}

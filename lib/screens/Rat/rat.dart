import 'package:fluttanim/utils/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class Rat extends HookWidget {
  const Rat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var offset = useState(Offset.zero);
    var duration = useState(0);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.indigo[400],
        child: GestureDetector(
          onPanStart: (details) {
            duration.value = 0;
          },
          onPanUpdate: (details) {
            offset.value += details.delta;
          },
          onPanEnd: (details) {
            duration.value = 1000;
            offset.value = Offset.zero;
          },
          child: AnimatedTranslation(
            offset: offset.value,
            curve: Curves.elasticOut,
            duration: Duration(
              milliseconds: duration.value,
            ),
            child: Center(
              child: Ball(offset: offset.value),
            ),
          ),
        ),
      ),
    );
  }
}

const double radius = 50;

class Ball extends StatelessWidget {
  const Ball({Key key, this.offset}) : super(key: key);
  final Offset offset;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Transform.scale(
      scale: Interpolate(
              inputRange: [-size.height / 2, size.height / 2],
              outputRange: [0.2, 1.8],
              extrapolate: Extrapolate.clamp)
          .eval(offset.dy),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

import 'package:fluttanim/utils/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';
import 'package:fluttanim/utils/utils.dart';

class Channel extends HookWidget {
  Channel({Key key}) : super(key: key);
  final List<String> images = [
    "https://picsum.photos/1080/720",
    "https://picsum.photos/1080/721",
    "https://picsum.photos/1080/722",
    "https://picsum.photos/1080/723",
    "https://picsum.photos/1080/724",
    "https://picsum.photos/1080/725",
    "https://picsum.photos/1080/726",
    "https://picsum.photos/1080/727",
    "https://picsum.photos/1080/728",
    "https://picsum.photos/1080/729",
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double minHeight = 128;
    double maxHeight = size.height / 2;
    var y = useState(0.0);
    var duration = useState(0);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Container(
          height: maxHeight * 10,
          width: size.width,
          color: Colors.black87,
          child: GestureDetector(
            onPanStart: (details) {
              duration.value = 0;
            },
            onPanUpdate: (details) {
              y.value = clamp(y.value + details.delta.dy,
                  -maxHeight * (images.length - 1), 0);
            },
            onPanEnd: (details) {
              duration.value = 200;
              var velocity = details.velocity.pixelsPerSecond.dy;
              var points =
                  List.generate(images.length, (index) => index * -maxHeight);
              var dest = snapPoint(y.value, velocity, points);
              y.value = dest;
            },
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: AnimatedTranslation(
                duration: Duration(milliseconds: duration.value),
                offset: Offset(0, y.value),
                child: Column(
                  children: List.generate(10, (index) {
                    return AnimatedContainer(
                      duration: Duration(
                        milliseconds: duration.value,
                      ),
                      width: size.width,
                      height: Interpolate(inputRange: [
                        (index - 1) * maxHeight,
                        index * maxHeight
                      ], outputRange: [
                        minHeight,
                        maxHeight,
                      ], extrapolate: Extrapolate.clamp)
                          .eval(-y.value),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

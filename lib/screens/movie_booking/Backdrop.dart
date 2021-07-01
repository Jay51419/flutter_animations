import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';

class Backdrop extends StatelessWidget {
  final ValueNotifier<double> x;
  final ValueNotifier<int> duration;
  Backdrop({
    Key key,
    @required this.x,
    @required this.duration,
  }) : super(key: key);
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
    var movieWidth = (size.width * 0.75);
    return Stack(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: List.generate(
            images.length,
            (index) {
              return Align(
                child: AnimatedContainer(
                  duration: Duration(
                    milliseconds: duration.value,
                  ),
                  height: 0.6 * size.height,
                  width: Interpolate(inputRange: [
                    (index - 1) * movieWidth,
                    (index) * movieWidth,
                    (index + 1) * movieWidth,
                  ], outputRange: [
                    0,
                    size.width,
                    0,
                  ], extrapolate: Extrapolate.clamp)
                      .eval(x.value),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Opacity(
            opacity: 0.5,
            child: Container(
              height: 0.6 * size.height,
              width: size.width,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

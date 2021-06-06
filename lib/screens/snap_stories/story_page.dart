import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class StoryPage extends HookWidget {
  final Color color;
  final int index;
  const StoryPage({
    Key key,
    @required this.color,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = useState(Colors.transparent);
    var size = MediaQuery.of(context).size;
    var offset = useState(Offset(0, 0));
    var scale = useState(1.0);
    var opacity = useState(0.0);
    var isGestureActive = useState(false);
    var isSlidingDown = useState(false);
    return Scaffold(
      key: key,
      backgroundColor: backgroundColor.value,
      body: Container(
        height: size.height,
        width: size.width,
        child: GestureDetector(
          onPanStart: (details) {
            offset.value = Offset.zero;
            isGestureActive.value = true;
          },
          onPanUpdate: (details) {
            var dx = (offset.value.dx + details.delta.dx);
            var dy = (offset.value.dy + details.delta.dy);
            if (dy > 10) {
              backgroundColor.value = Colors.transparent;
              isSlidingDown.value = true;
              opacity.value = 0;
              offset.value = Offset(dx, dy);
              scale.value = Interpolate(
                inputRange: [0, size.height],
                outputRange: [1, 0.5],
                extrapolate: Extrapolate.clamp,
              ).eval(offset.value.dy);
            } else {
              isSlidingDown.value = false;
              backgroundColor.value = Colors.black;
              opacity.value = 1;
              offset.value = Offset(dx, 0);
              scale.value = Interpolate(
                inputRange: [-size.width, 0, size.width],
                outputRange: [0.5, 1, 0.5],
                extrapolate: Extrapolate.clamp,
              ).eval(offset.value.dx);
            }
          },
          onPanEnd: (details) {
            if (offset.value.dy > size.height / 3) {
              Navigator.of(context).pop();
            } else {
              offset.value = Offset.zero;
              scale.value = 1;
            }
            isGestureActive.value = false;
          },
          child: Transform.translate(
            offset: offset.value,
            child: Stack(
              children: [
                Transform.scale(
                  scale: scale.value,
                  child: Hero(
                    tag: index,
                    key: Key("$index"),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: size.height,
                      width: size.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: isGestureActive.value
                            ? BorderRadius.circular(20)
                            : BorderRadius.circular(0),
                      ),
                      child: Image.network(
                        "https://picsum.photos/1080/1920",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: opacity.value,
                  child: Transform.translate(
                    offset: Offset(-size.width, 0),
                    child: Transform.scale(
                      scale: 0.8,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: size.height,
                        width: size.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: isGestureActive.value
                              ? BorderRadius.circular(20)
                              : BorderRadius.circular(0),
                        ),
                        child: Image.network(
                          "https://picsum.photos/1080/1920",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: opacity.value,
                  child: Transform.translate(
                    offset: Offset(size.width, 0),
                    child: Transform.scale(
                      scale: 0.8,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: size.height,
                        width: size.width,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: isGestureActive.value
                              ? BorderRadius.circular(20)
                              : BorderRadius.circular(0),
                        ),
                        child: Image.network(
                          "https://picsum.photos/1080/1920",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
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

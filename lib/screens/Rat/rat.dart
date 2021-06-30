import 'package:animated/animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Rat extends HookWidget {
  const Rat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isPressed = useState(false);
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: GestureDetector(
          onTap: () {
            isPressed.value = !isPressed.value;
          },
          child: Center(
            child: Animated(
              value: isPressed.value ? 10 : 1,
              duration: Duration(milliseconds: 1000),
              builder: (BuildContext context, Widget child,
                  Animation<dynamic> animation) {
                return Transform.scale(
                  scale: animation.value,
                  child: child,
                );
              },
              child: Ball(),
            ),
          ),
        ),
      ),
    );
  }
}

const double radius = 50;

class Ball extends StatelessWidget {
  const Ball({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

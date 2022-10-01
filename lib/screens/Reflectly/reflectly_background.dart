import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class ReflectlyBackground extends HookWidget {
  const ReflectlyBackground({
    Key key,
    this.offset,
    this.colors,
  }) : super(key: key);
  final Offset offset;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var controller =
        useAnimationController(duration: Duration(milliseconds: 2000));
    useValueChanged(colors[0], (_, __) {
      controller.reset();
      controller.forward();
    });
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return ShaderMask(
          child: child,
          blendMode: BlendMode.src,
          shaderCallback: (rect) {
            return RadialGradient(
              colors: colors,
              center: Alignment(
                Interpolate(inputRange: [
                  size.width / 3,
                  size.width / 2,
                  size.width,
                ], outputRange: [
                  -0.5,
                  0,
                  0.5
                ], extrapolate: Extrapolate.clamp)
                    .eval(offset.dx),
                Interpolate(inputRange: [
                  size.width / 3,
                  size.width / 2,
                  size.width,
                ], outputRange: [
                  0.1,
                  0,
                  -0.1
                ], extrapolate: Extrapolate.clamp)
                    .eval(offset.dx),
              ),
              radius: controller.value * 5,
            ).createShader(rect);
          },
        );
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: Colors.white),
      ),
    );
  }
}

import 'dart:math';

import 'package:fluttanim/screens/circular_slider/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

const double tabHeight = 80;

class LiquidTabBar extends HookWidget {
  final List<IconData> tabs = [
    Icons.home,
    Icons.search,
    Icons.add_a_photo,
    Icons.album,
    Icons.person,
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var tabWidth = size.width / tabs.length;
    var controller =
        useAnimationController(duration: Duration(milliseconds: 300));
    var iconController =
        useAnimationController(duration: Duration(milliseconds: 300));

    var activeTab = useState(0);
    var color = useAnimation(
        ColorTween(begin: Colors.white, end: Colors.amber[400])
            .animate(controller));
    var activeIconColor = useAnimation(
        ColorTween(begin: Colors.black, end: Colors.amber)
            .animate(iconController));
    var width = useAnimation(
        Tween<double>(begin: size.width, end: size.width * 0.8)
            .animate(controller));
    var iconSize = useAnimation(
        Tween<double>(begin: (size.width / tabs.length), end: 0)
            .animate(controller));
    var borderRadius =
        useAnimation(Tween<double>(begin: 0, end: 50).animate(controller));
    var y = useAnimation(
        Tween<double>(begin: 0, end: -tabHeight).animate(controller));

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Transform.translate(
              offset: Offset(-size.width / 2, -tabHeight),
              child: CustomPaint(
                painter: LiquidPainter(),
              ),
            ),
            Container(
              height: tabHeight,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: tabs
                    .map(
                      (value) => GestureDetector(
                        onTap: () {
                          activeTab.value = tabs.indexOf(value);
                          controller.forward().whenComplete(
                                () => controller.reverse(),
                              );
                          iconController.reset();
                          iconController.forward();
                        },
                        child: Container(
                          height: tabHeight,
                          alignment: Alignment.center,
                          width: activeTab.value != tabs.indexOf(value)
                              ? (size.width / tabs.length)
                              : iconSize,
                          child: Icon(
                            value,
                            size:
                                activeTab.value != tabs.indexOf(value) ? 30 : 0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Transform.translate(
                offset: Offset(
                  tabWidth * activeTab.value,
                  y,
                ),
                child: Container(
                    height: tabHeight,
                    alignment: Alignment.center,
                    width: (size.width / tabs.length),
                    child: Icon(tabs[activeTab.value],
                        size: 30, color: activeIconColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LiquidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Path path = Path();
    path.quadraticBezierTo(20, -20, 15, -20);
    path.arcToPoint(-polar2canvas(center: 200, radius: 50, theta: pi / 1.2),
        radius: Radius.circular(40));
    path.quadraticBezierTo(50, 20, 15, 50);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiquidPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(LiquidPainter oldDelegate) => false;
}

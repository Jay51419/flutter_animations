import 'dart:math';
import 'dart:ui';

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
  final List<Color> colors = [
    Colors.yellow.shade300,
    Colors.pink.shade300,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var tabWidth = size.width / tabs.length;
    var controller =
        useAnimationController(duration: Duration(milliseconds: 600));
    var ballController =
        useAnimationController(duration: Duration(milliseconds: 600));

    var activeTab = useState(0);
    var color = useAnimation(
        ColorTween(begin: Colors.white, end: colors[activeTab.value])
            .animate(controller));
    var width = useAnimation(
        Tween<double>(begin: size.width, end: size.width * 0.8)
            .animate(controller));
    var iconSize = useAnimation(
        Tween<double>(begin: (size.width / tabs.length), end: 0)
            .animate(controller));
    var borderRadius =
        useAnimation(Tween<double>(begin: 0, end: 50).animate(controller));
    var y = useAnimation(
        Tween<double>(begin: 0, end: -tabHeight - 30).animate(ballController));

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.matrix([
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                1,
                0,
                0,
                0,
                0,
                0,
                18,
                -7.0 * 255
              ]),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                  tileMode: TileMode.decal,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Transform.scale(
                        origin: Offset(tabWidth * activeTab.value, y - 20),
                        scale: Interpolate(
                            inputRange: [-tabHeight - 30, -tabHeight, 0],
                            outputRange: [0, 1, 1]).eval(y),
                        child: Transform.translate(
                            offset: Offset(
                              (tabWidth * activeTab.value),
                              y - 20,
                            ),
                            child: SizedBox(
                              height: 50,
                              width: tabWidth,
                              child: Align(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: tabHeight - 5,
                      width: width - 5,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: tabHeight,
              width: width + 40,
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
                          ballController.forward().whenComplete(() =>
                              Future.delayed(Duration(milliseconds: 600),
                                  () => ballController.reset()));
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
              child: Transform.scale(
                origin: Offset(
                  tabWidth * activeTab.value,
                  y,
                ),
                scale: Interpolate(
                    inputRange: [-tabHeight - 30, -tabHeight, 0],
                    outputRange: [0, 1, 1]).eval(y),
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
                          size: 25, color: Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

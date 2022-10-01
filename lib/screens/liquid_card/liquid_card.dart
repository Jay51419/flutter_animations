import 'dart:math';
import 'dart:ui';

import 'package:animated/animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const double minCardHeight = 150;
const double maxCardHeight = 200;

class LiquidCard extends HookWidget {
  const LiquidCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardWidth = 0.6 * size.width;
    var isOpen = useState(false);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(
            top: size.height / 4,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                sticky(isOpen, 25, 20),
                sticky(isOpen, 70, 15),
                sticky(isOpen, cardWidth * 0.6, 14),
                sticky(isOpen, cardWidth * 0.7, 13),
                sticky(isOpen, cardWidth * 0.8, 20),
                Animated(
                  duration: Duration(milliseconds: 300),
                  value:
                      isOpen.value ? minCardHeight + 100 : minCardHeight * 0.7,
                  builder: (BuildContext context, Widget child,
                      Animation<dynamic> animation) {
                    return Transform.translate(
                      offset: Offset(0, animation.value),
                      child: child,
                    );
                  },
                  child: Container(
                    height: minCardHeight,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade800,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                Container(
                  height: maxCardHeight,
                  width: 0.6 * size.width,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade800,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Un sillion",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.volume_up_rounded,
                            size: 25,
                            color: Colors.white54,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "see-yohn",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(cardWidth / 2 - 25, maxCardHeight - 25),
                  child: GestureDetector(
                    onTap: () => isOpen.value = !isOpen.value,
                    child: AnimatedContainer(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: isOpen.value
                                ? Colors.black45
                                : Colors.transparent,
                            blurRadius: 25,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      duration: Duration(milliseconds: 300),
                      child: Animated(
                        value: isOpen.value ? pi * 2.5 : pi * 1.5,
                        builder: (BuildContext context, Widget child,
                            Animation<dynamic> animation) {
                          return Transform.rotate(
                            angle: animation.value,
                            child: child,
                          );
                        },
                        child: Icon(
                          Icons.chevron_left,
                          size: 30,
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

  ColorFiltered sticky(ValueNotifier<bool> isOpen, double x, double width) {
    return ColorFiltered(
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
        child: Column(
          children: [
            Animated(
              duration: Duration(milliseconds: 400),
              value: isOpen.value ? 0 : 50,
              builder: (BuildContext context, Widget child,
                  Animation<dynamic> animation) {
                return Transform.translate(
                  offset: Offset(x, animation.value),
                  child: child,
                );
              },
              child: Container(
                width: width,
                height: maxCardHeight,
                color: Colors.purple.shade800,
              ),
            ),
            Animated(
              duration: Duration(milliseconds: 400),
              value: isOpen.value ? 50 : -minCardHeight,
              builder: (BuildContext context, Widget child,
                  Animation<dynamic> animation) {
                return Transform.translate(
                  offset: Offset(x, animation.value),
                  child: child,
                );
              },
              child: Container(
                width: width,
                height: minCardHeight / 2,
                color: Colors.purple.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget gap() {
  return SizedBox(width: 30);
}

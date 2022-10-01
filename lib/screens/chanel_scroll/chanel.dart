import 'package:fluttanim/screens/chanel_scroll/item.dart';
import 'package:fluttanim/utils/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';
import 'package:fluttanim/utils/utils.dart';

class Chanel extends HookWidget {
  Chanel({Key key}) : super(key: key);
  final List<Item> images = [
    Item(
      title: "Upcoming Show Live from Paris",
      subtitle: "SPRING-SUMMER 2021",
      image: AssetImage("assets/chanel/chanel.jpg"),
    ),
    Item(
      title: "In Boutiques",
      subtitle: "FALL-WINTER 2020/21",
      image: AssetImage(
          "assets/chanel/sonnie-hiles-pU4J5VFnqCQ-unsplash-with-gradient.jpg"),
    ),
    Item(
      title: "Deauville Film Festival",
      subtitle: "CHANEL IN CINEMA",
      image: AssetImage(
          "assets/chanel/laura-chouette-NFrPPyGe5q0-unsplash-with-gradient.jpg"),
    ),
    Item(
      title: "IN BOUTIQUES",
      subtitle: "Métiers d'art 2019/20",
      image: AssetImage(
          "assets/chanel/butsarakham-buranaworachot-au6Gddf1pZQ-unsplash.jpg"),
    ),
    Item(
      title: "Haute Couture",
      subtitle: "FALL-WINTER 2020/21",
      image:
          AssetImage("assets/chanel/khaled-ghareeb-upepKTbwm3A-unsplash.jpg"),
    ),
    Item(
      title: "Balade en Méditerranée",
      subtitle: "CRUISE 2020/21",
      image: AssetImage(
          "assets/chanel/christopher-campbell-A3QXXEfcA1U-unsplash.jpg"),
    ),
    Item(
      title: "Spring-Summer 2020 Campaign",
      subtitle: "EYEWEAR",
      image: AssetImage("assets/chanel/chase-fade-Pb13EUxzMDw-unsplash.jpg"),
    ),
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
                  children: List.generate(images.length, (index) {
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
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image(
                            image: images[index].image,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  Colors.transparent,
                                  Colors.black54
                                ])),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Container(
                              width: size.width,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: Interpolate(inputRange: [
                                      (index - 1) * maxHeight,
                                      index * maxHeight
                                    ], outputRange: [
                                      0,
                                      20,
                                    ], extrapolate: Extrapolate.clamp)
                                            .eval(-y.value)),
                                    child: Text(
                                      images[index].subtitle.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Opacity(
                                      opacity: Interpolate(inputRange: [
                                        (index - 1) * maxHeight,
                                        index * maxHeight
                                      ], outputRange: [
                                        0,
                                        1,
                                      ], extrapolate: Extrapolate.clamp)
                                          .eval(-y.value),
                                      child: Text(
                                        images[index].title.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
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

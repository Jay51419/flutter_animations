import 'package:fluttanim/screens/Reflectly/reflectly_background.dart';
import 'package:fluttanim/screens/Reflectly/reflectly_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class ReflectlyColors extends HookWidget {
  ReflectlyColors({Key key}) : super(key: key);
  final colors = [
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.lightBlue,
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var pageController = usePageController(viewportFraction: 0.3);
    var x = useState(0.0);
    var active = useState(0);
    var activeColors = useState(colors[active.value]);
    var previousColors = useState(colors[active.value]);
    var colorOffset = useState(Offset.zero);
    var colorWidth = size.width * 0.3;
    useEffect(() {
      pageController.addListener(() {
        x.value = pageController.offset;
      });
      return;
    });
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: ReflectlyBackground(colors: [
                activeColors.value,
                previousColors.value,
              ], offset: colorOffset.value),
            ),
            PageView.builder(
              controller: pageController,
              itemCount: colors.length,
              allowImplicitScrolling: true,
              onPageChanged: (index) {
                active.value = index;
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTapDown: (details) {
                    pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                    if (index != colors.indexOf(activeColors.value)) {
                      colorOffset.value = details.globalPosition;
                      print(colorOffset.value);
                      previousColors.value = activeColors.value;
                      activeColors.value = colors[index];
                    }
                  },
                  child: Transform.scale(
                    scale: Interpolate(
                      inputRange: [
                        (index - 1) * colorWidth,
                        (index) * colorWidth,
                        (index + 1) * colorWidth,
                      ],
                      outputRange: [0.8, 1, 0.8],
                      extrapolate: Extrapolate.clamp,
                    ).eval(x.value),
                    child: Transform.translate(
                      offset: Offset(
                          0,
                          Interpolate(
                            inputRange: [
                              (index - 1) * colorWidth,
                              (index) * colorWidth,
                              (index + 1) * colorWidth,
                            ],
                            outputRange: [-50, 0, 50],
                            extrapolate: Extrapolate.clamp,
                          ).eval(x.value)),
                      child: ReflectlyColor(
                        color: colors[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fluttanim/screens/circular_slider/slider.dart';
import 'package:flutter/material.dart';

class CircularSlider extends StatelessWidget {
  const CircularSlider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Center(
          child: CustomSlider(),
        ),
      ),
    );
  }
}

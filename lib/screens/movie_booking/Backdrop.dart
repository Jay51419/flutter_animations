import 'package:flutter/material.dart';
import 'package:interpolate/interpolate.dart';

import 'movie_model.dart';

class Backdrop extends StatelessWidget {
  final ValueNotifier<double> x;
  final ValueNotifier<int> duration;
  Backdrop({
    Key key,
    @required this.x,
    @required this.duration,
  }) : super(key: key);
  final List<MovieModel> images = [
    MovieModel(
      name: "SpiderMan",
      image: AssetImage("assets/movie/spiderman.jpg"),
    ),
    MovieModel(
      name: "Washington DC",
      image: AssetImage("assets/movie/Washington_dc.jpg"),
    ),
    MovieModel(
      name: "Batman",
      image: AssetImage("assets/movie/batman.jpg"),
    ),
    MovieModel(
      name: "Grand Lake",
      image: AssetImage("assets/movie/grand_lake.jpg"),
    ),
    MovieModel(
      name: "Abstraction",
      image: AssetImage("assets/movie/abstraction.jpg"),
    ),
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
                  height: size.height,
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
                  child: Image(
                    image: images[index].image,
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
              height: size.height,
              width: size.width,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:fluttanim/screens/movie_booking/Backdrop.dart';
import 'package:fluttanim/screens/movie_booking/movie.dart';
import 'package:fluttanim/screens/movie_booking/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:interpolate/interpolate.dart';

class Movies extends HookWidget {
  Movies({Key key}) : super(key: key);
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
    var pageController = usePageController(viewportFraction: 0.75);
    var x = useState(0.0);
    var active = useState(0.0);
    var movieWidth = size.width * 0.75;
    var duration = useState(0);
    useEffect(() {
      pageController.addListener(() {
        x.value = pageController.offset;
      });
      return;
    });
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white10,
        child: Stack(
          children: [
            Positioned(top: 0, child: Backdrop(x: x, duration: duration)),
            PageView.builder(
              controller: pageController,
              allowImplicitScrolling: true,
              itemCount: images.length,
              onPageChanged: (index) {
                active.value = index.toDouble();
              },
              itemBuilder: (BuildContext context, int index) {
                return Transform.scale(
                  scale: Interpolate(inputRange: [
                    (index - 1) * movieWidth,
                    (index) * movieWidth,
                    (index + 1) * movieWidth,
                  ], outputRange: [
                    1,
                    1.2,
                    1
                  ], extrapolate: Extrapolate.clamp)
                      .eval(x.value),
                  child: Transform.translate(
                    offset: Offset(
                        0,
                        Interpolate(inputRange: [
                          (index - 1) * movieWidth,
                          (index) * movieWidth,
                          (index + 1) * movieWidth,
                        ], outputRange: [
                          0,
                          -20,
                          0
                        ], extrapolate: Extrapolate.clamp)
                            .eval(x.value)),
                    child: Movie(
                        key: Key("$index"),
                        image: images[index].image,
                        width: size.width),
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

import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Donut extends StatelessWidget {
  const Donut({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.amber,
        child: Center(
          child: Cube(
            onSceneCreated: (Scene scene) {
              scene.world.add(
                Object(fileName: 'assets/donut1.obj'),
              );
              scene.camera.zoom = 5;
            },
          ),
        ),
      ),
    );
  }
}

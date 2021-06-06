import 'package:fluttanim/screens/snap_stories/story_page.dart';
import "package:flutter/material.dart";
import 'package:fluttanim/screens/snap_stories/story.dart';

class Stories extends StatelessWidget {
  const Stories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: 20,
          itemBuilder: (BuildContext ctx, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return Stack(
                          children: [
                            StoryPage(
                              index: index,
                              color: Color.fromRGBO(
                                  index, index * 7, index * 8, 1),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  key: Key("$index"),
                  tag: index,
                  child: Story(
                    color: Color.fromRGBO(index, index * 7, index * 8, 1),
                  ),
                ));
          },
        ),
      ),
    );
  }
}

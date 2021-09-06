import 'package:fluttanim/screens/Reflectly/reflectly_colors.dart';
import 'package:fluttanim/screens/channel_scroll/channel.dart';
import 'package:fluttanim/screens/gooey_cell/gooey_cell.dart';
import 'package:fluttanim/screens/liquid_tabbar/liquid_tabbar.dart';
import 'package:fluttanim/screens/movie_booking/movies.dart';
import 'package:fluttanim/screens/rubber_range_picker/rubber_range_picker.dart';
import 'package:fluttanim/screens/snap_stories/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'balloon_range_picker/balloon_range_picker.dart';
// import 'circular_slider/circular_slider.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  final List screens = [
    {"name": "📱 Snapchat Stories", "screen": Stories()},
    {"name": "📜 Channel Scroll", "screen": Channel()},
    {"name": "🎥 Movie Booking", "screen": Movies()},
    {"name": "🌈 Reflectly Colors", "screen": ReflectlyColors()},
    {"name": "🏹 Rubber Range Picker", "screen": RubberRangePicker()},
    {"name": "🎈 Balloon Range Picker", "screen": BalloonRangePicker()},
    {"name": "❣️ Gooey Cell", "screen": GooeyCell()},
    // {"name": "🪐 Circular Slider", "screen": CircularSlider()},
    {"name": "〰️ Liquid TabBar", "screen": LiquidTabBar()},
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        height: size.height,
        width: size.width,
        child: ListView.builder(
          itemCount: screens.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
                  return screens[index]["screen"];
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.indigo[800],
                    width: 0.05,
                  ),
                ),
                child: Text(
                  screens[index]["name"],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

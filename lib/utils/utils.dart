import 'dart:math';

import 'package:flutter/material.dart';

double snapPoint(double value, double velocity, List<double> points) {
  var point = value + 0.2 * velocity;
  var deltas = points.map((p) => (point - p).abs()).toList();
  var minDelta = deltas.reduce(min);
  return points.where((p) => (point - p).abs() == minDelta).toList()[0];
}

double clamp(double value, double lower, double upper) {
  return min(max(lower, value), upper);
}

double distance(Offset offset1, Offset offset2) {
  return sqrt(pow(offset2.dx - offset1.dx, 2)) +
      sqrt(pow(offset2.dy - offset1.dy, 2));
}

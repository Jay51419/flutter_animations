import 'package:flutter/material.dart';

class AnimatedTranslation extends ImplicitlyAnimatedWidget {
  final Offset offset;
  final Widget child;
  AnimatedTranslation(
      {Key key,
      @required Duration duration,
      @required this.offset,
      this.child,
      Curve curve = Curves.linear})
      : super(key: key, duration: duration, curve: curve);

  @override
  _AnimatedTranslationState createState() => _AnimatedTranslationState();
}

class _AnimatedTranslationState
    extends AnimatedWidgetBaseState<AnimatedTranslation> {
  Tween<Offset> _offset;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offset.animate(animation).value,
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _offset = visitor(
        _offset, widget.offset, (dynamic value) => Tween<Offset>(begin: value));
  }
}

class AnimatedScale extends ImplicitlyAnimatedWidget {
  final double scale;
  final Widget child;
  AnimatedScale(
      {Key key,
      @required Duration duration,
      Curve curve = Curves.linear,
      @required this.scale,
      this.child})
      : super(key: key, duration: duration, curve: curve);

  @override
  _AnimatedScaleState createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends AnimatedWidgetBaseState<AnimatedScale> {
  Tween<double> _scale;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _scale.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _scale = visitor(
        _scale, widget.scale, (dynamic value) => Tween<double>(begin: value));
  }
}

class AnimatedRotatation extends ImplicitlyAnimatedWidget {
  final double angle;
  final Widget child;
  AnimatedRotatation(
      {Key key,
      @required Duration duration,
      Curve curve = Curves.linear,
      @required this.angle,
      this.child})
      : super(key: key, duration: duration, curve: curve);

  @override
  _AnimatedRotatationState createState() => _AnimatedRotatationState();
}

class _AnimatedRotatationState
    extends AnimatedWidgetBaseState<AnimatedRotatation> {
  Tween<double> _angle;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _angle = visitor(
        _angle, widget.angle, (dynamic value) => Tween<double>(begin: value));
  }
}

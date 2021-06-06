import 'package:flutter/material.dart';

class AnimatedTranslation extends ImplicitlyAnimatedWidget {
  final Offset offset;
  final Widget child;
  AnimatedTranslation({Key key, Duration duration, this.offset, this.child})
      : super(key: key, duration: duration);

  @override
  _AnimatedTranslationState createState() => _AnimatedTranslationState();
}

class _AnimatedTranslationState
    extends AnimatedWidgetBaseState<AnimatedTranslation> {
  Tween<Offset> _offset;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offset.evaluate(animation),
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
  AnimatedScale({Key key, Duration duration, this.scale, this.child})
      : super(key: key, duration: duration);

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
        _scale, widget.scale, (dynamic value) => Tween<Offset>(begin: value));
  }
}

class AnimatedRotatation extends ImplicitlyAnimatedWidget {
  final double angle;
  final Widget child;
  AnimatedRotatation({Key key, Duration duration, this.angle, this.child})
      : super(key: key, duration: duration);

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
        _angle, widget.angle, (dynamic value) => Tween<Offset>(begin: value));
  }
}

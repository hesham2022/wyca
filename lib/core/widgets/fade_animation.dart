import 'package:flutter/material.dart';

class FadedAnimation extends StatefulWidget {
  const FadedAnimation({
    super.key,
    required this.child,
    Curve? curve,
    this.onEnd,
    this.duration = const Duration(seconds: 2),
    this.durationToBegin = const Duration(milliseconds: 100),
  }) : _curve = curve ?? Curves.linear;

  final Duration duration;
  final Duration durationToBegin;
  final VoidCallback? onEnd;
  final Widget child;
  final Curve _curve;
  @override
  State<FadedAnimation> createState() => _FadedAnimationState();
}

class _FadedAnimationState extends State<FadedAnimation> {
  @override
  void initState() {
    Future.delayed(widget.durationToBegin, () {
      setState(() {
        opacity = 1;
      });
    });
    super.initState();
  }

  double opacity = 0;
  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        curve: widget._curve,
        opacity: opacity,
        onEnd: widget.onEnd,
        duration: widget.duration,
        child: widget.child,
      );
}
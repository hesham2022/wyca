import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget(
    this.name, {
    super.key,
    this.controller,
    this.animate,
    this.frameRate,
    this.repeat,
    this.reverse,
    this.delegates,
    this.options,
    this.onLoaded,
    this.imageProviderFactory,
    this.bundle,
    this.errorBuilder,
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.package,
    this.addRepaintBoundary,
  });
  final String name;
  final Animation<double>? controller;
  final bool? animate;
  final FrameRate? frameRate;
  final bool? repeat;
  final bool? reverse;
  final LottieDelegates? delegates;
  final LottieOptions? options;
  final void Function(LottieComposition)? onLoaded;
  final LottieImageProviderFactory? imageProviderFactory;

  final AssetBundle? bundle;
  final ImageErrorWidgetBuilder? errorBuilder;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;
  final String? package;
  final bool? addRepaintBoundary;
  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Lottie.asset(
        widget.name,
        controller: _controller,
        animate: widget.animate,
        frameRate: widget.frameRate,
        repeat: widget.repeat,
        reverse: widget.reverse,
        delegates: widget.delegates,
        options: widget.options,
        onLoaded: widget.onLoaded,
        imageProviderFactory: widget.imageProviderFactory,
        bundle: widget.bundle,
        errorBuilder: widget.errorBuilder,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
        package: widget.package,
        addRepaintBoundary: widget.addRepaintBoundary,
      );
}

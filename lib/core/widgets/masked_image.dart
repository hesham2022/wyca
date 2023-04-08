import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:wyca/core/widgets/widget.dart';

class MaskedImage extends StatelessWidget {
  const MaskedImage({super.key, required this.image, required this.child});
  final ImageProvider image;
  final Widget child;
  Future<ui.Image> loadImage() async {
    final completer = Completer<ui.Image>();

    image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((info, _) {
        return completer.complete(info.image);
      }),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<ui.Image>(
        future: loadImage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Loader());
          } else {
            return ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) => ImageShader(
                snapshot.data!,
                TileMode.clamp,
                TileMode.clamp,
                Matrix4.identity().storage,
              ),
              child: child,
            );
          }
        },
      );
}

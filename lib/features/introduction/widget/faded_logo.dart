import 'package:flutter/material.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/introduction/pages/intro_screen.dart';
import 'package:wyca/gen/assets.gen.dart';

class FadedLogo extends StatelessWidget {
  const FadedLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return FadedAnimation(
      onEnd: () {
        Navigator.of(context).push<void>(
            MaterialPageRoute(builder: (context) => const IntroScreen()));
      },
      child: Assets.images.logo.image(),
    );
  }
}

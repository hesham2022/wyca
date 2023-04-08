import 'package:flutter/material.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/features/auth/presentation/pages/user_type_screen.dart';
import 'package:wyca/gen/colors.gen.dart';

class IntroBottomBar extends StatelessWidget {
  const IntroBottomBar({
    super.key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const UserTypeScreen(),
              ),
            );
          },
          child: Text(
            'Skip',
            style: kBody1Style.copyWith(
              color: ColorName.textColor1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        TextButton(
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          child: Text(
            'Next',
            style: kBody1Style.copyWith(
              color: ColorName.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

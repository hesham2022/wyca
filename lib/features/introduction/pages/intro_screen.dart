import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/pages/user_type_screen.dart';
import 'package:wyca/features/introduction/widget/intro_bottom_bar.dart';
import 'package:wyca/features/introduction/widget/page_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // create page controller
  late PageController _pageController;

  // create current page
  final int _currentPage = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    _pageController.addListener(() {
      for (final position in _pageController.positions) {
        if (position.pixels == position.maxScrollExtent) {
          setState(() {
            showStateButton = true;
          });
        } else {
          setState(() {
            showStateButton = false;
          });
        }
      }
    });
    super.initState();
  }

  bool showStateButton = false;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: kPadding.copyWith(bottom: 36.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Welcome To Wyca',
                    style: kHead1Style,
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: const [
                        PageWidget(
                          title: 'DIRTY CAR',
                          bodyText: '''
LOREM IPSUM DOLOR SIT AMET, CONSECTETUER ADIPISCING ELIT, SED DIAM NONUMMY''',
                        ),
                        PageWidget(
                          title: 'WYCA AT YOUR SERVICE',
                          bodyText: '''
LOREM IPSUM DOLOR SIT AMET, CONSECTETUER ADIPISCING ELIT, SED DIAM NONUMMY''',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 0,
                    width: 2,
                    child: SmoothPageIndicator(
                      effect: WormEffect(
                        dotHeight: 6.h,
                        dotWidth: 6.h,
                        activeDotColor: kPrimaryColor,
                        spacing: 10,
                        radius: 10,
                      ),
                      count: 2,
                      controller: _pageController,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  // intro screen row
                  if (showStateButton)
                    AppButton(
                      title: 'Start',
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (context) => const UserTypeScreen(),
                          ),
                        );
                      },
                    )
                  else
                    IntroBottomBar(pageController: _pageController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

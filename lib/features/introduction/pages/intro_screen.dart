import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/core/routing/routes.gr.dart' as router;
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/pages/user_type_screen.dart';
import 'package:wyca/features/introduction/data.dart';
import 'package:wyca/gen/colors.gen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // create page controller
  PageController? _controller;
  int currentIndex = 0;
  double percentage = 0.25;
  late StreamSubscription<AuthenticationState> _authenticationStateSubscription;
  @override
  void initState() {
    _controller = PageController();
    if (context.read<AuthenticationBloc>().state.status ==
            AuthenticationStatus.authenticated &&
        context.read<AuthenticationBloc>().state.provider == null &&
        context.read<AuthenticationBloc>().state.user.role == 'user') {
      Future<void>.delayed(const Duration(), () {
        context.router.pushAndPopUntil<void>(
          router.HomePAGE(),
          predicate: (route) => false,
        );
      });
    }
    if (context.read<AuthenticationBloc>().state.status ==
            AuthenticationStatus.authenticatedProvider &&
        context.read<AuthenticationBloc>().state.provider != null) {
      Future<void>.delayed(const Duration(), () {
        context.router.pushAndPopUntil<void>(
          const router.ProviderHomeRoute(),
          predicate: (route) => false,
        );
      });
    }

    _authenticationStateSubscription =
        context.read<AuthenticationBloc>().stream.listen((state) {
      if (state.status == AuthenticationStatus.authenticated) {
        context.router.pushAndPopUntil<void>(
          router.HomePAGE(),
          predicate: (route) => false,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _authenticationStateSubscription.cancel();
    super.dispose();
  }

  bool showStateButton = false;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: contentsList[currentIndex].backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Expanded(
                  flex: 20,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contentsList.length,
                    onPageChanged: (int index) {
                      if (index >= currentIndex) {
                        setState(() {
                          currentIndex = index;
                          percentage += 0.25;
                        });
                      } else {
                        setState(() {
                          currentIndex = index;
                          percentage -= 0.25;
                        });
                      }
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(contentsList[index].image, height: 200),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .status
                                    .toString(),
                              ),
                              Column(
                                children: [
                                  Text(
                                    contentsList[index].title,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      letterSpacing: 0.24,
                                      color: ColorName.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  contentsList[index].discription,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contentsList.length,
                                  (index) => buildDot(index, context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (context) => const UserTypeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: ColorName.primaryColor,
                        ),
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute(
                            builder: (context) => const UserTypeScreen(),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 55,
                            child: CircularProgressIndicator(
                              value: percentage,
                              backgroundColor: const Color(0xffbacae3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                ColorName.primaryColor,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: ColorName.primaryColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: contentsList[currentIndex].backgroundColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 8,
      width: currentIndex == index ? 24 : 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? ColorName.primaryColor
            : const Color(0xffbacae3),
      ),
    );
  }
}

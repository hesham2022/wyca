// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/widgets/app_loader.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/home/presentation/pages/offer_details_page.dart';
import 'package:wyca/features/user/home/presentation/widgets/home_item.dart';
import 'package:wyca/gen/colors.gen.dart';
import 'package:wyca/l10n/l10n.dart';

import '../../../../../core/api_config/api_constants.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../auth/data/models/cars_model.dart';

class HomeCursorSlider extends StatefulWidget {
  const HomeCursorSlider({super.key});

  @override
  State<HomeCursorSlider> createState() => _HomeCursorSliderState();
}

class _HomeCursorSliderState extends State<HomeCursorSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PackagesCubit, PackagesCubitState>(
        builder: (context, state) {
          if (state is PackagesCubitStateLoading) {
            return const Center(
              child: Loader(),
            );
          }
          if (state is PackagesCubitStateError) {
            return Center(
              child: Text(state.error.errorMessege),
            );
          }
          final currentState = state as PackagesCubitStateLoaded;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 400,
                child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, _) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                  items: currentState.featuredPackages.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => OfferDetailsPage(
                                  package: i,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 30,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 0.5,
                                              blurRadius: 15)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 15),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AutoSizeText(
                                                i.name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              autoSizeText(
                                                text: i.description,
                                                fontWeight: FontWeight.w600,
                                                size: 16,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                autoSizeText(
                                                  text:
                                                      '${i.price - i.priceDiscount} ${context.l10n.le}',
                                                  size: 14,
                                                ),
                                                autoSizeText(
                                                  text:
                                                      ' ${i.price} ${context.l10n.le}  ',
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.red,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 130,
                                              height: 50,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push<void>(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          OfferDetailsPage(
                                                        package: i,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Order Now",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 15,
                                  child: Image.asset(
                                    "assets/images/car.png",
                                    width: 150,
                                    height: 100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    currentState.featuredPackages.length,
                    (index) => 'text',
                  ).asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 6.w,
                          height: 6.w,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? ColorName.primaryColor
                                : const Color(0xff8F8F8F),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        },
      );
}

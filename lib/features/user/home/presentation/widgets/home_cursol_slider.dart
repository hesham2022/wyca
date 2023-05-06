// ignore_for_file: lines_longer_than_80_chars, use_decorated_box

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
                height: 150,
                width: MediaQuery.of(context).size.width * .8,
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
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: cashedImage(
                                    url: kImagePackage + i.image,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: ListTile(
                                    title: autoSizeText(
                                      text: i.name,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        autoSizeText(
                                          text: i.description,
                                          fontWeight: FontWeight.w600,
                                          size: 16,
                                          maxLines: 2,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        autoSizeText(
                                          text:
                                              '${context.l10n.with_price} ${i.price - i.priceDiscount} ${context.l10n.le}',
                                          size: 14,
                                        ),
                                        autoSizeText(
                                          text:
                                              '${context.l10n.instead_of} ${i.price} ${context.l10n.le}  ',
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.red,
                                          size: 14,
                                        ),
                                      ],
                                    ),
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

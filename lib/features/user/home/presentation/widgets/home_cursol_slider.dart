import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/widgets/app_loader.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/home/presentation/pages/offer_details_page.dart';
import 'package:wyca/features/user/home/presentation/widgets/home_item.dart';
import 'package:wyca/gen/colors.gen.dart';

class HomeCursolSlider extends StatefulWidget {
  const HomeCursolSlider({super.key});

  @override
  State<HomeCursolSlider> createState() => _HomeCursolSliderState();
}

class _HomeCursolSliderState extends State<HomeCursolSlider> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
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
              return CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  height: 200.h,
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
                        child: HomeItem(
                          package: i,
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => 'text')
                .asMap()
                .entries
                .map((entry) {
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
            }).toList(),
          ),
        ],
      );
}

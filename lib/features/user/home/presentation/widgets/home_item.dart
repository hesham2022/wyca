import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/gen/colors.gen.dart';
import 'package:wyca/imports.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    this.package,
  });

  final Package? package;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(width: .1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              child: package != null
                  ? cashedImage(
                      url: kImagePackage + package!.image,
                    )
                  : Image.asset(
                      Assets.images.car.path,
                      fit: BoxFit.fill,
                    ),
            ),
          ),

          ///
          ///
          ///
          ///
          // Container(
          //   width: 224.w,
          //   height: 130.h,
          //   margin: const EdgeInsets.symmetric(horizontal: 5),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(4),
          //     image: package != null
          //         ? DecorationImage(
          //             fit: BoxFit.cover,
          //             image: NetworkImage(
          //               kImagePackage + package!.image,
          //               //   Assets.images.car.path,
          //             ),
          //           )
          //         : DecorationImage(
          //             fit: BoxFit.cover,
          //             image: AssetImage(
          //               Assets.images.car.path,
          //             ),
          //           ),
          //   ),
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       // backgroundBlendMode: BlendMode.hue,
          //       // gradient: LinearGradient(
          //       //   begin: Alignment.bottomCenter,
          //       //   end: Alignment.topCenter,
          //       //   stops: const [0.1, 0.3, 31, 32, 33, 34, 35, 36, .4],
          //       //   colors: [
          //       //     const Color(0xff0F70F5).withOpacity(.9),
          //       //     const Color(0xFFF9F9F9).withOpacity(.8),
          //       //     const Color(0xFFF9F9F9).withOpacity(.7),
          //       //     const Color(0xFFF9F9F9).withOpacity(.6),
          //       //     const Color(0xFFF9F9F9).withOpacity(.5),
          //       //     const Color(0xFFF9F9F9).withOpacity(.4),
          //       //     const Color(0xFFF9F9F9).withOpacity(.3),
          //       //     const Color(0xFFF9F9F9).withOpacity(.2),
          //       //     const Color(0xFFF9F9F9).withOpacity(0),
          //       //   ],
          //       // ),
          //     ),
          //   ),
          //   // child: Image.network(
          //   //   'https://www.kia.com/us/content/dam/kia/us/en/home2-0/tout-cards/kia_card-tout_ev6.jpg',
          //   // ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LayoutBuilder(
              builder: (context, b) {
                return SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      autoSizeText(
                        text: package!.name,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (package!.priceDiscount > 0)
                            autoSizeText(
                              text: '${package!.price} ${context.l10n.le}',
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red,
                            ),
                          if (package!.priceDiscount > 0)
                            autoSizeText(
                              text:
                                  '${package!.price - package!.priceDiscount} ${context.l10n.le}',
                              fontWeight: FontWeight.w700,
                            ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget cashedImage({required String url}) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.fill,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
    ),
    placeholder: (context, url) => const LoadingIndicator(
      indicatorType: Indicator.ballClipRotateMultiple,
      colors: [ColorName.primaryColor],
      strokeWidth: 2,
      backgroundColor: Colors.white,
      pathBackgroundColor: Colors.black,
    ),
  );
}

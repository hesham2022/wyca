import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/gen/assets.gen.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    this.package,
  });
  final Package? package;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(width: .1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: 224.w,
            height: 130.h,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: package != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        kImagePackage + package!.image,
                        //   Assets.images.car.path,
                      ),
                    )
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        Assets.images.car.path,
                      ),
                    ),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // backgroundBlendMode: BlendMode.hue,
                // gradient: LinearGradient(
                //   begin: Alignment.bottomCenter,
                //   end: Alignment.topCenter,
                //   stops: const [0.1, 0.3, 31, 32, 33, 34, 35, 36, .4],
                //   colors: [
                //     const Color(0xff0F70F5).withOpacity(.9),
                //     const Color(0xFFF9F9F9).withOpacity(.8),
                //     const Color(0xFFF9F9F9).withOpacity(.7),
                //     const Color(0xFFF9F9F9).withOpacity(.6),
                //     const Color(0xFFF9F9F9).withOpacity(.5),
                //     const Color(0xFFF9F9F9).withOpacity(.4),
                //     const Color(0xFFF9F9F9).withOpacity(.3),
                //     const Color(0xFFF9F9F9).withOpacity(.2),
                //     const Color(0xFFF9F9F9).withOpacity(0),
                //   ],
                // ),
              ),
            ),
            // child: Image.network(
            //   'https://www.kia.com/us/content/dam/kia/us/en/home2-0/tout-cards/kia_card-tout_ev6.jpg',
            // ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LayoutBuilder(
              builder: (context, b) {
                return SizedBox(
                  width: 224,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(package!.name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${package!.price} LE',
                            style: kBody1Style.copyWith(
                              decoration: package!.priceDiscount > 0
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),

                          if (package!.priceDiscount > 0)
                            Text(
                              '${package!.price - package!.priceDiscount} LE',
                              style: kBody1Style.copyWith(),
                            ),
                          // const SizedBox(
                          //   width: 100,
                          // ),
                          // Text(
                          //   package!.priceDiscount.toString(),
                          //   style: kBody1Style.copyWith(
                          //     decoration: package!.priceDiscount > 0
                          //         ? TextDecoration.lineThrough
                          //         : null,
                          //   ),
                          // ),
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

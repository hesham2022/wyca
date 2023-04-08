// import material
import 'package:flutter/material.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/features/user/order/presentation/pages/chosse_adresse_page.dart';
import 'package:wyca/features/user/order/presentation/pages/isPackage_exist.dart';
import 'package:wyca/imports.dart';
// import theme

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key, required this.package});
  final Package package;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(context, package.name, titleColor: ColorName.textColor3),
        body: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (package.priceDiscount > 0)
                      Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${package.price} LE',
                                  style: kHead1Style.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w300,
                                    fontSize: ScreenUtil().setSp(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${package.price - package.priceDiscount} LE',
                                  style: kHead1Style.copyWith(
                                    fontSize: ScreenUtil().setSp(20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${package.price} LE',
                              style: kHead1Style.copyWith(
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (!isPackageExist(context, package.id) &&
                        restOfWash(context, package.id) == 0)
                      const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      )

                    // ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                const SectionTitile('Wash Number'),

                Text(
                  '${package.washNumber} Wash',
                  style:
                      kHead1Style.copyWith(color: kPrimaryColor, fontSize: 14),
                ),

                if (isPackageExist(context, package.id) &&
                    restOfWash(context, package.id) != 0)
                  Column(
                    children: [
                      const SectionTitile('You Have '),
                      Text(
                        '${restOfWash(context, package.id)} Wash',
                        style: kHead1Style.copyWith(
                          color: kPrimaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SectionTitile('Our Features'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ...List.generate(
                  package.features.length,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: FeatureWidget(
                      isOrderedList: false,
                      description: package.features[index].description,
                      //  '''Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy''',
                      title: package.features[index].title,
                      index: index,
                    ),
                  ),
                ),

                SizedBox(
                  height: 25.h,
                ),
                const SectionTitile('More'),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  package.description,
                  //   '''Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy Lorem Ipsum Dolor Sit Amet,Consectetuer Adipiscing Elit, Sed Lorem Ipsum Dolor Sit Amet, Consectetuer''',
                  style: kSemiBoldStyle.copyWith(
                    fontSize: ScreenUtil().setSp(14),
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // const SectionTitile('Our Work'),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Grid View

                // GridView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: 10,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 4,
                //     crossAxisSpacing: 10.w,
                //     mainAxisSpacing: 10.w,
                //   ),
                //   itemBuilder: (context, index) => Container(
                //     // height: 200.h,
                //     // width: 200.h,
                //     decoration: BoxDecoration(
                //       image: const DecorationImage(
                //         fit: BoxFit.cover,
                //         image: NetworkImage(
                //           'https://images.pexels.com/photos/372810/pexels-photo-372810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                //         ),
                //       ),
                //       borderRadius: BorderRadius.circular(6),
                //     ),
                //   ),
                // ),
                // GridView
                SizedBox(
                  height: 50.h,
                ),
                AppButton(
                  title: 'Service Request',
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChosseAdressePage(
                          packageId: package.id,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      );
}

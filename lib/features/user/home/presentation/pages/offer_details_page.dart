// import material
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/features/user/order/presentation/pages/chosse_adresse_page.dart';
import 'package:wyca/features/user/order/presentation/pages/isPackage_exist.dart';
import 'package:wyca/imports.dart';

import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/presentation/bloc/user_cubit.dart';
import 'home_page.dart';
// import theme

class OfferDetailsPage extends StatelessWidget {
  const OfferDetailsPage({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: appBar(context, package.name, titleColor: ColorName.textColor3),
        appBar: AppBar(
          title: Text(
            package.name,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (package.priceDiscount > 0)
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            context.l10n.wash_num,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${package.washNumber} ${context.l10n.wash}',
                            style: TextStyle(
                              color: ColorName.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ],
                      ),
                      if (isPackageExist(context, package.id) &&
                          restOfWash(context, package.id) != 0)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              context.l10n.you_have,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(24),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${restOfWash(context, package.id)} ${context.l10n.wash}',
                              style: TextStyle(
                                color: ColorName.primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            ),
                          ],
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${package.price - package.priceDiscount} ${context.l10n.le}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenUtil().setSp(24),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${package.price} ${context.l10n.le}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ],
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
                  ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  context.l10n.features,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(24),
                  ),
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
                Text(
                  context.l10n.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  package.description,
                  style: kSemiBoldStyle.copyWith(
                    fontSize: ScreenUtil().setSp(16),
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
                  title: context.l10n.serviceRequest,
                  onPressed: () {
                    try {
                      Address? currentAdress = (context.read<UserCubit>().state
                              as UserCubitStateLoaded)
                          .user
                          .addresses
                          .last;
                      if (currentAdress != null) {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChosseAdressePage(
                              packageId: package.id,
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      showLocationDialog(context);
                    }
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

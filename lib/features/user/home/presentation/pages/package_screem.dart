import 'package:flutter/material.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/features/user/order/presentation/pages/chosse_adresse_page.dart';
import 'package:wyca/features/user/order/presentation/pages/isPackage_exist.dart';
import 'package:wyca/imports.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key, required this.package});
  final Package package;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(
          context,
          package.name,
          titleColor: ColorName.textColor3,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    if (isPackageExist(context, package.id) &&
                        restOfWash(context, package.id) == 0)
                      const Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      )
                    // AppButton(
                    //   w: 146.w,
                    //   h: 36.h,
                    //   title: context.l10n.buyNow,
                    //   onPressed: () {
                    //     Navigator.push<void>(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const ChosseAdressePage(),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const SectionTitile('Wash Number'),
                Text(
                  '${package.washNumber} Wash',
                  style: kBody1Style.copyWith(color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (isPackageExist(context, package.id) &&
                    restOfWash(context, package.id) != 0)
                  Column(
                    children: [
                      const SectionTitile('You Have '),
                      Row(
                        children: [
                          Text(
                            '${restOfWash(context, package.id)} Wash',
                            style: kBody1Style.copyWith(color: kPrimaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20.h,
                ),
                if (package.features.isNotEmpty)
                  SectionTitile(context.l10n.features),
                SizedBox(
                  height: 20.h,
                ),
                ...List.generate(
                  package.features.length,
                  (index) {
                    final _currentPage = package.features[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: FeatureWidget(
                        index: index,
                        title: _currentPage.title,
                        description: _currentPage.description,
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.h),
                SectionTitile(context.l10n.moreAboutPackage),
                Text(
                  package.description,
                  style: kSemiBoldStyle.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                AppButton(
                  title: (isPackageExist(context, package.id) &&
                          restOfWash(context, package.id) != 0)
                      ? context.l10n.serviceRequest
                      : context.l10n.buy,
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
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      );
}

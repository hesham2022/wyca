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
        appBar: AppBar(
          title: Text(package.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      context.l10n.wash_num,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: ScreenUtil().setSp(18),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${package.washNumber} ${context.l10n.wash}',
                      style: kBody1Style.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${package.price} ${context.l10n.le}',
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
                if (isPackageExist(context, package.id) &&
                    restOfWash(context, package.id) != 0)
                  autoSizeText(
                    text:
                        '${context.l10n.remain} : ${restOfWash(context, package.id)}',
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                  ),
                SizedBox(
                  height: 20.h,
                ),
                if (package.features.isNotEmpty)
                  autoSizeText(
                      text: context.l10n.features, fontWeight: FontWeight.w700),
                SizedBox(
                  height: 10.h,
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
                autoSizeText(
                    text: context.l10n.moreAboutPackage,
                    fontWeight: FontWeight.w700),
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
                Center(
                  child: AppButton(
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

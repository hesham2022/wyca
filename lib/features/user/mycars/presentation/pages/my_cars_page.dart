import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/core/api_config/index.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/user/mycars/presentation/pages/add_new_car_page.dart';
import 'package:wyca/imports.dart';

class MyCarsPage extends StatelessWidget {
  const MyCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.myCars)),
      body: BlocBuilder<UserCubit, UserCubitState>(
        builder: (context, state) {
          return Padding(
            padding: kPadding,
            child: Column(
              children: [

                const SizedBox(
                  height: 5,
                ),
                for (final i in (state as UserCubitStateLoaded).user.cars)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        // Assets.svg.carShape.svg(
                        //   height: 28.h,
                        //   width: 68.w,
                        //   color: ColorName.primaryColor,
                        // ),

                        Image.network(
                          '$domain/img/cars/${i.photo}',
                          width: 110.h,
                          height: 110.h,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              i.type,
                              style: kHead1Style.copyWith(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              i.color,
                              style: kHead1Style.copyWith(fontSize: 12.sp),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                AppButton(
                  h: 36.h,
                  title: context.l10n.addNewCar,
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddNewCarPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

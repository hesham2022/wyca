// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/companmy_setting/data/models/company_seting_model.dart';
import 'package:wyca/features/companmy_setting/data/models/complaint_model.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/calling_bloc.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/comlainment_cubit.dart';
import 'package:wyca/features/companmy_setting/presentation/widgets/button_1.dart';
import 'package:wyca/features/companmy_setting/presentation/widgets/common_container.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/l10n/l10n.dart';

final reasons = <String>[
  'Installment request',
  'High / low pressure',
  'Increased sweating',
  'Dizziness',
  'Cough',
  'Breathing difficulties',
  'Flaky skin'
];
final selectedList = <String>[];

class ContactMethod {
  ContactMethod({required this.icon, this.info, required this.url, this.func});
  final String url;
  final String icon;
  final String? info;
  final Function? func;
}

class CallingPage extends StatefulWidget {
  const CallingPage({super.key});

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  List<ContactMethod> contactMethods(ComapnySettingsModel model) => [
        ContactMethod(icon: Assets.svg.mail.path, url: 'mailto:${model.email}'),
        // ContactMethod(icon: Assets.svg.web.path, url: model.website),
        ContactMethod(icon: Assets.svg.facebook.path, url: model.facebook),
        ContactMethod(
          icon: Assets.svg.insta.path,
          url: model.insta,
        ),
        ContactMethod(icon: Assets.svg.twitter.path, url: model.twitter),
        // ContactMethod(
        //   icon: Assets.svg.whatsapp.path,
        //   url: 'https://wa.me/${model.phone}',
        // ),
        ContactMethod(
          icon: Assets.svg.phone.path,
          url: 'tel:${model.phone}',
          func: (BuildContext context, List<String> phones) {
            showDialog<void>(
              context: context,
              builder: (context) {
                return Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 500, // Change as per your requirement
                    width: 500, // Change as per your requirement
                    child: phones.isEmpty
                        ? const Center(
                            child: Text('No Phone Number'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: phones.length,
                            itemBuilder: (BuildContext context, int index) {
                              final phone = phones[index];
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      launchUrl(
                                        Uri.parse('tel:$phone'),
                                      );
                                    },
                                    title: Text(
                                      phone,
                                      style: kBody1Style,
                                    ),
                                    trailing: SvgPicture.asset(
                                      Assets.svg.phone.path,
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  )
                                ],
                              );
                            },
                          ),
                  ),
                );
              },
            );
          },
        ),
      ];
  @override
  void initState() {
    final bloc = context.read<CallingBloc>();
    final state = bloc.state;
    if (state is CallingInitial) {
      bloc.add(GetComapnySettingsEvent());
    }
    super.initState();
  }

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: BlocBuilder<CallingBloc, CallingState>(
            builder: (context, state) {
              if (state is CallingLoaded) {
                return Column(
                  children: [
                    // SizedBox(height: 25.h),

                    // // CommonContainer(
                    // //   height: 40.h,
                    // //   color: Colors.white.withOpacity(.6),
                    // // ),

                    // SizedBox(height: 25.h),
                    CommonContainer(
                      // height: 200.h,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Expanded(
                            //   child:
                            //       Assets.svg.phone.svg(height: 30, width: 30),
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   height: 1,
                            //   color: Colors.red,
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text(
                                //   'SUPPORT SERVICE',
                                //   textAlign: TextAlign.center,
                                //   style: textStyleWithSecondSemiBold.copyWith(
                                //     fontSize: 12.sp,
                                //     fontFamily: 'Oswald',
                                //     height: 1,
                                //     color: const Color(0xff1AA9A0),
                                //   ),
                                // ),
                                Text(
                                  'Contact us',
                                  textAlign: TextAlign.center,
                                  style: textStyleWithPrimaryBold.copyWith(
                                    fontSize: 30,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You can reach us anytime via\n wyca.online@gmail.com',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style:
                                          textStyleWithSecondSemiBold.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    SizedBox(
                      height: 220,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 40.w,
                          childAspectRatio: 141 / 124,
                        ),
                        itemCount:
                            contactMethods(state.comapnySettingsModel).length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => setState(() {
                              current = index;
                              print(
                                contactMethods(
                                  state.comapnySettingsModel,
                                )[index]
                                    .url,
                              );
                              if (contactMethods(
                                    state.comapnySettingsModel,
                                  )[index]
                                      .func !=
                                  null) {
                                contactMethods(
                                  state.comapnySettingsModel,
                                )[index]
                                    .func!(
                                  context,
                                  state.comapnySettingsModel.phones,
                                );
                              } else {
                                launchUrl(
                                  Uri.parse(
                                    contactMethods(
                                      state.comapnySettingsModel,
                                    )[index]
                                        .url,
                                  ),
                                );
                              }
                            }),
                            child: CommonContainer(
                              color: current == index
                                  ? kPrimaryColor
                                  : Colors.white,
                              br: 23,
                              height: 92.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      contactMethods(
                                        state.comapnySettingsModel,
                                      )[index]
                                          .icon,
                                      color: current == index
                                          ? Colors.white
                                          : kPrimaryColor,
                                      height: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // const Text(
                    //   'Add Compalint',
                    // ), //

                    const AddCompliant(),

                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                );
              }
              if (state is CallingFailed) {
                return Center(
                  child: Text(state.error.errorMessege),
                );
              }
              if (state is CallingLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center();
            },
          ),
        ),
      ),
    );
  }
}

class AddCompliant extends StatefulWidget {
  const AddCompliant({
    super.key,
  });

  @override
  State<AddCompliant> createState() => _AddCompliantState();
}

class _AddCompliantState extends State<AddCompliant> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final complaintmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplaintCubit, ComplaintState>(
      listener: (context, state) {
        print(state);
        if (state is ComplaintSuccess) {
          EasyLoading.dismiss();

          nameController.clear();
          emailController.clear();
          phoneController.clear();
          complaintmentController.clear();
          showDialog<void>(
            context: context,
            builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: SizedBox(
                height: ScreenUtil().setHeight(440),
                width: ScreenUtil().setWidth(440),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 330.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Comapiant Sent And Follow up Number is ',
                                    textAlign: TextAlign.center,
                                    style: kBody1Style.copyWith(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    state.complaintment.number ?? '',
                                    style: kBody1Style.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.purple,
                                      ),
                                    ),
                                    child: Container(
                                      height: 150.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.purple,
                                        ),
                                      ),
                                      child: Assets.svg.checkMark.svg(
                                        height: 50.h,
                                        width: 50.h,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Thank you',
                                    style: kBody1Style.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Button1(
                            onPressed: context.router.pop,
                            title: 'Done',
                            size: const Size(142, 30),
                            titelStyle: kBody1Style.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          // EasyLoading.showInfo(
          //   'Your Complaint has been Send And Complaint Number is 62178367} ',
          // );
        }
        if (state is ComplaintFailure) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error.errorMessege);
        }
        if (state is ComplaintLoading) {
          EasyLoading.show();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: context.l10n.name, /*Or Mobiel Number*/
              ),
              controller: nameController,
              validator: (p0) {
                if (p0!.isEmpty) {
                  return 'Name is Invalid';
                }
                return null;
              },
            ).commonFild(context),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: context.l10n.email, /*Or Mobiel Number*/
              ),
              // hint: context.l10n.email,
              controller: emailController,
              validator: (email) {
                return null;

                // if (!ValidationsPatterns.emailValidate.hasMatch(email!)) {
                //   return context.l10n.invalidEmail;
                // }
                // return null;
              },
            ).commonFild(context),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: context.l10n.mobileNumber, /*Or Mobiel Number*/
              ),
              controller: phoneController,
              validator: (phoneNumber) {
                const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                final phoneRegx = RegExp(patttern);
                if (!phoneRegx.hasMatch(phoneNumber!)) {
                  return 'Invalid mobile number';
                }
                return null;
              },
            ).commonFild(context),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'HOW CAN WE HELP?',
              ),
              maxLines: 10,
              controller: complaintmentController,
              validator: (name) {
                if (name!.isEmpty) {
                  return 'Please enter a Complainment';
                }
                return null;
              },
              // fillColor: Colors.white,
            ).commonFild(context),
            const SizedBox(
              height: 15,
            ),
            AppButton(
              w: 119.w,
              title: context.l10n.send,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ComplaintCubit>().addCompliantment(
                        ComplaintModel(
                          name: nameController.text,
                          email: emailController.text,
                          phoneNumber: phoneController.text,
                          complaintment: complaintmentController.text,
                          userPhoneNumber: phoneController.text,
                        ),
                      );
                }
              },
              // title: 'Send',
            )
          ],
        ),
      ),
    );
  }
}

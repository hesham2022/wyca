import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/auth/presentation/pages/confirm_location_page.dart';
import 'package:wyca/features/auth/presentation/widgets/login_bar.dart';
import 'package:wyca/imports.dart';

class SignUpSecond extends StatefulWidget {
  const SignUpSecond({super.key});

  @override
  State<SignUpSecond> createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
  final picker = ImagePicker();
  final photoController = TextEditingController();
  final frontIdController = TextEditingController();
  final backIdController = TextEditingController();
  final criminalFishController = TextEditingController();

  Future<String?> pickPhoto(TextEditingController textEditingController) async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      textEditingController.text = image.path.split('/').last;
      return image.path;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              const LogoBar(
                title: 'Create A New Account',
              ),
              SizedBox(
                height: 25.h,
              ),
              const Text(
                'You Photo',
              ),
              SizedBox(
                height: 2.h,
              ),
              ChoosePictureField(
                controller: photoController,
                onTap: () async {
                  final photo = await pickPhoto(photoController);
                  if (photo != null) {
                    Future<void>.delayed(Duration.zero, () {
                      context
                          .read<RegisterProviderBloc>()
                          .add(LoginPhotoChanged(photo));
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Front Id',
              ),
              SizedBox(
                height: 2.h,
              ),
              ChoosePictureField(
                controller: frontIdController,
                onTap: () async {
                  final photo = await pickPhoto(frontIdController);
                  if (photo != null) {
                    Future<void>.delayed(Duration.zero, () {
                      context
                          .read<RegisterProviderBloc>()
                          .add(LoginFrontIdChanged(photo));
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Back Id',
              ),
              SizedBox(
                height: 2.h,
              ),
              ChoosePictureField(
                controller: backIdController,
                onTap: () async {
                  final photo = await pickPhoto(backIdController);
                  if (photo != null) {
                    Future<void>.delayed(Duration.zero, () {
                      context
                          .read<RegisterProviderBloc>()
                          .add(LoginBackIdChanged(photo));
                    });
                  }
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Criminal Fish With A Recent History',
              ),
              SizedBox(
                height: 2.h,
              ),
              ChoosePictureField(
                controller: criminalFishController,
                onTap: () async {
                  final photo = await pickPhoto(criminalFishController);
                  if (photo != null) {
                    Future<void>.delayed(Duration.zero, () {
                      context
                          .read<RegisterProviderBloc>()
                          .add(LoginCriminalFishChanged(photo));
                    });
                  }
                },
              ),
              SizedBox(
                height: 60.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      color: Colors.white,
                      titleColor: ColorName.primaryColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: 'Previous',
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: BlocBuilder<RegisterProviderBloc, LoginState>(
                      // buildWhen: (previous, current) =>
                      //     previous.status != current.status,

                      builder: (contextA, state) {
                        print(
                          '''
 state.photo.error == ${state.photo.error} &&
                                  state.criminalFish.error == ${state.criminalFish.error} &&
                                  state.backId.error == ${state.backId.error}  &&
                                  state.frontId.error == ${state.frontId.error}

''',
                        );
                        return AppButton(
                          onPressed: (state.photo.error == null &&
                                  state.criminalFish.error == null &&
                                  state.backId.error == null &&
                                  state.frontId.error == null)
                              ? () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (contextq) =>
                                          ConfirmLocationPage(
                                        onConfirm:
                                            (p0, placemark, address, des) {
                                          context
                                              .read<RegisterProviderBloc>()
                                              .add(
                                                LoginAddAddress(
                                                  address: address,
                                                  coordinates: [
                                                    p0.latitude,
                                                    p0.longitude
                                                  ],
                                                ),
                                              );
                                          Future.delayed(Duration.zero, () {
                                            contextA
                                                .read<RegisterProviderBloc>()
                                                .add(
                                                  const LoginRegisterSubmitted(),
                                                );
                                          });

                                          // contextA
                                          //     .read<RegisterProviderBloc>()
                                          //     .add(
                                          //       const LoginRegisterSubmitted(),
                                          //     );
                                        },
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          title: 'Next',
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36.h),
            ],
          ),
        ),
      ),
    );
  }
}

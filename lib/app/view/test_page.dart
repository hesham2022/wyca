import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/domain/params/login_params.dart';
import 'package:wyca/features/auth/domain/repositories/i_respository.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String? image;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    final _image = await _picker.pickImage(source: ImageSource.gallery);
    image = _image!.path;
    print(image);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () async {
              // try {
              //   await pickImage();
              final authRemote = getIt<IAuthenticationRepository>();
              final result = await authRemote.logInProvider(
                LoginParam(
                  password: 'A12345678a',
                  email: 'ggggg@gmail.com',
                ),
              );
              print(result);
              //   await authRemote.signUpProvider(
              //     await RegisterUserParams(
              //       phoneNumber: '01097353354',
              //       criminalFish: image!,
              //       address: 'asdasd',
              //       email: 'asdajd@dsd.com',
              //       coordinates: [23, 34],
              //       photo: image!,
              //       fcm: kFcm,
              //       gender: 'male',
              //       name: 'sadasd',
              //       password: 'A12345678a',
              //       backId: image!,
              //       frontId: image!,
              //     ).toMap(),
              //   );
              // } catch (e) {
              //   if (e is DioError) {
              //     print(e.response);
              //   }
              // }

              // final result = await getIt<IAuthenticationRepository>().logIn(
              //   LoginParam(
              //     // name: 'Hesham',
              //     email:
              //         'admin@gmail.com', //'te${Random().nextInt(1000)}sdsst@nwkef.com',
              //     // gender: 'male',
              //     password: 'A12345678a@',
              //     // fcm: 'kjwnejkdf',
              //   ),
              // );
              // result.fold(
              //   (l) => print(l.errorMessege),
              //   (r) => print('success'),
              // );
              // final userResult = getIt<GetUser>();

              // final user = await userResult(NoParams());
              // user.fold(
              //   print,
              //   print,
              // );
              // IUserRepository
            },
            child: const Text('test'),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/pages/login.dart';
import 'package:wyca/features/auth/presentation/pages/provider/provider_login.dart';
import 'package:wyca/gen/colors.gen.dart';

String kUserType = '';
// name: 'User',
//                   ),
//                   DropDownModel(
//                     name: 'Provider',x

void userAction({
  required VoidCallback isUser,
  required VoidCallback isProvider,
}) {
  print(kUserType);
  if (kUserType == 'User') {
    isUser();
  }
  if (kUserType == 'Provider') {
    isProvider();
  }
}

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  DropDownModel? userType;

  @override
  Widget build(BuildContext context) {
    return AppForm(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(3),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              // we will give media query height
              // double.infinity make it big as my parent allows
              // while MediaQuery make it big as per the screen

              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                // even space distribution
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'To the easiest way to keep your car looking \n fresh and clean!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Lottie.asset('assets/lottie/welcome.json'),
                  ),
                  Column(
                    children: <Widget>[
                      // the login button
                      MaterialButton(
                        minWidth: 200,
                        height: 40,
                        onPressed: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        // defining the shape
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: ColorName.primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'User',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      // creating the signup button
                      const SizedBox(height: 20),
                      MaterialButton(
                        minWidth: 200,
                        height: 40,
                        onPressed: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute(
                              builder: (context) => const ProviderLogin(),
                            ),
                          );
                        },
                        color: ColorName.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Provider',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/app/app.dart';
import 'package:wyca/core/widgets/language_dropdwonfield.dart';

class LanguageDialuge extends StatefulWidget {
  const LanguageDialuge({
    super.key,
  });

  @override
  State<LanguageDialuge> createState() => _LanguageDialugeState();
}

class _LanguageDialugeState extends State<LanguageDialuge> {
  final languages = const [
    LanguageModel(name: 'English', local: 'en'),
    LanguageModel(name: 'Arabic', local: 'ar')
  ];
  late String _currenLocal;
  @override
  void initState() {
// get current local language
    Future.delayed(Duration.zero, () async {
      setState(() {
        _currenLocal = Localizations.localeOf(context).languageCode;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: SizedBox(
        height: ScreenUtil().setHeight(200.h),
        width: ScreenUtil().setWidth(300),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                'Choose The Language',
                style: kSemiBoldStyle.copyWith(fontSize: 16.sp),
              ),
              ...languages
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.name),
                        Radio<String>(
                          activeColor: ColorName.primaryColor,
                          value: e.local,
                          groupValue: _currenLocal,
                          onChanged: (value) {
                            setState(() {
                              _currenLocal = value!;
                              App.changeLanguage(context, _currenLocal);
                            });
                          },
                        ),
                      ],
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

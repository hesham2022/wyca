import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/calling_bloc.dart';
import 'package:wyca/l10n/l10n.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    final bloc = context.read<CallingBloc>();
    final state = bloc.state;
    if (state is CallingInitial) {
      bloc.add(GetComapnySettingsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.termsAndConditions),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              BlocBuilder<CallingBloc, CallingState>(
                builder: (context, state) {
                  if (state is CallingLoaded) {
                    return RichText(
                      text: TextSpan(
                        text: context.l10n.localeName == 'ar'
                            ? ' مرحبًا بك في Wyca! باستخدام تطبيقنا ، فإنك توافق على الشروط والأحكام التالية\n'
                            : 'Welcome to Wyca! By using our app, you agree to the following terms and conditions \n',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: context.l10n.localeName == 'ar'
                              ? 'Cairo'
                              : 'Lobster',
                        ),
                        children: [
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'مقدمة\n'
                                : 'Introduction\n',
                            style: bigStyle(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? ' تحكم هذه الشروط والأحكام استخدامك لتطبيق Wyca. يرجى قراءتها بعناية قبل استخدام التطبيق\n'
                                : 'These terms and conditions govern your use of the Wyca app. Please read them carefully before using the app. \n',
                            style: style(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'المصطلحات الأساسية\n'
                                : 'Key Terms\n',
                            style: bigStyle(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'المصطلحات الأساسية: يشير مصطلح "Wyca" إلى تطبيقنا ، ويشير "المستخدم" إلى أي شخص يستخدم التطبيق ، وتشير "الخدمة" إلى خدمة غسيل السيارات الجاف المقدمة من خلال التطبيق. \n'
                                : '"Wyca" refers to our app, "user" refers to anyone who uses the app, and "service" refers to the dry car wash service provided through the app. \n',
                            style: style(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'حقوق ومسؤوليات المستخدم\n'
                                : 'Privacy\n',
                            style: bigStyle(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'نحن نأخذ خصوصية المستخدم على محمل الجد. سيتم استخدام أي معلومات شخصية يتم جمعها من خلال التطبيق فقط لغرض توفير الخدمة ولن تتم مشاركتها مع أي جهات خارجية ، باستثناء ما يقتضيه القانون. يرجى الاطلاع على سياسة الخصوصية الخاصة بنا للحصول على مزيد من المعلومات حول كيفية تعاملنا مع بيانات المستخدم. \n'
                                : 'We take user privacy very seriously. Any personal information collected through the app will be used solely for the purpose of providing the service and will not be shared with any third parties, except where required by law. Please see our privacy policy for more information on how we handle user data. \n',
                            style: style(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'إخلاء المسؤولية\n'
                                : 'Disclaimer\n',
                            style: bigStyle(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'نحن نأخذ خصوصية المستخدم على محمل الجد. سيتم استخدام أي معلومات شخصية يتم جمعها من خلال التطبيق فقط لغرض توفير الخدمة ولن تتم مشاركتها مع أي جهات خارجية ، باستثناء ما يقتضيه القانون. يرجى الاطلاع على سياسة الخصوصية الخاصة بنا للحصول على مزيد من المعلومات حول كيفية تعاملنا مع بيانات المستخدم. \n'
                                : ' We make every effort to provide a high-quality and reliable service through the app. However, we cannot guarantee that the service will be uninterrupted or error-free. We are not responsible for any loss or damage that may occur as a result of using the app or the service provided through the app. We reserve the right to suspend or terminate your use of the app at any time, without notice.\n',
                            style: style(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'إذا كانت لديك أي أسئلة أو مشكلات تتعلق بتطبيق Wyca ، فلا تتردد في الاتصال بنا على \n'
                                : 'If you have any questions or issues with the Wyca app, please do not hesitate to contact us at \n',
                            style: style(context),
                          ),
                          TextSpan(
                            text: context.l10n.localeName == 'ar'
                                ? 'ًWyca.online@gmail.com.\n'
                                : 'ًWyca.online@gmail.com.',
                            style: bigStyle(context),
                          ),
                        ],
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle style(BuildContext context) {
  return TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: context.l10n.localeName == 'ar' ? 'Cairo' : 'Lobster',
  );
}

TextStyle bigStyle(BuildContext context) {
  return TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: context.l10n.localeName == 'ar' ? 'Cairo' : 'Lobster',
  );
}

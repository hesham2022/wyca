import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';

class ProviderHowWashPage extends StatefulWidget {
  const ProviderHowWashPage({super.key});

  @override
  State<ProviderHowWashPage> createState() => _ProviderHowWashPageState();
}

class _ProviderHowWashPageState extends State<ProviderHowWashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, context.l10n.howToWashCar),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: [
            SectionTitile(
              context.l10n.howToWashCar,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const VedioWidget(),
            const SizedBox(height: 20),
            SectionTitile(
              context.l10n.steps,
              color: Colors.black,
            ),
            ...List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: FeatureWidget(
                  titleColor: ColorName.primaryColor,
                  description: 'Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy',
                  title: 'Water Conservation',
                  index: index,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

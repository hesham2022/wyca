import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wyca/features/auth/data/models/cars_model.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/imports.dart';

class AddNewCarPage extends StatefulWidget {
  const AddNewCarPage({super.key});

  @override
  State<AddNewCarPage> createState() => _AddNewCarPageState();
}

class _AddNewCarPageState extends State<AddNewCarPage> {
  final picker = ImagePicker();
  final typeController = TextEditingController();
  final numberController = TextEditingController();
  final colorController = TextEditingController();
  final photoController = TextEditingController();
  final photoHintController = TextEditingController();

  Future<String?> pickPhoto(TextEditingController textEditingController) async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      textEditingController.text = image.path.split('/').last;
      return image.path;
    }
    return null;
  }

  final _formContoller = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, context.l10n.myCars),
      body: SingleChildScrollView(
        child: Form(
          key: _formContoller,
          child: Padding(
            padding: kPadding,
            child: Column(
              children: [
                SectionTitile(
                  context.l10n.addNewCar,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: context.l10n.carType,
                  ),
                  onChanged: (v) {
                    typeController.text = v;
                  },
                  validator: (value) => typeController.text.isEmpty
                      ? 'type must not be empty'
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                SectionTitile(
                  context.l10n.carPhoto,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                ChoosePictureField(
                  controller: photoHintController,
                  validator: (value) => photoController.text.isEmpty
                      ? context.l10n.pleaseChoosePhoto
                      : null,
                  onTap: () async {
                    final photo =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (photo != null) {
                      photoHintController.text = photo.path.split('/').last;
                      photoController.text = photo.path;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SectionTitile(
                  context.l10n.carNumber,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: numberController,
                  validator: (value) => numberController.text.isEmpty
                      ? context.l10n.numberMustNotBeEmpty
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                SectionTitile(
                  context.l10n.carColor,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: colorController,
                  validator: (value) => colorController.text.isEmpty
                      ? context.l10n.colorMustNotBeEmty
                      : null,
                ),
                const SizedBox(
                  height: 15,
                ),
                AppButton(
                  title: 'Add',
                  onPressed: () {
                    if (_formContoller.currentState!.validate()) {
                      final car = Car(
                        photo: photoController.text,
                        number: numberController.text,
                        color: colorController.text,
                        type: typeController.text,
                      );

                      context.read<AuthenticationBloc>().add(UpdateCars(car));
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:flutter/material.dart';

import '../verificationscreen/verification.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final namecontroller = TextEditingController();
  final gendercontroller = TextEditingController();
  final qualificationcontroller = TextEditingController();
  final categorycontroller = TextEditingController();
  final placecontroller = TextEditingController();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: 'Register A Doctor',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              kHeight20,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: namecontroller,
                  hintText: 'Name',
                  icon: Icons.person),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Gender';
                    }
                    return null;
                  },
                  controller: gendercontroller,
                  hintText: 'Gender',
                  icon: Icons.male),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Qualifiacation';
                    }
                    return null;
                  },
                  controller: qualificationcontroller,
                  hintText: 'Qualifiacation',
                  icon: Icons.school),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Categorie';
                    }
                    return null;
                  },
                  controller: categorycontroller,
                  hintText: 'Categorie',
                  icon: Icons.category),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Place';
                    }
                    return null;
                  },
                  controller: placecontroller,
                  hintText: 'Place',
                  icon: Icons.location_on),
              const SizedBox(
                height: 25,
              ),
              CustomElevatedButtons(
                text: 'Next',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationScreen(
                                name: namecontroller.text,
                                gender: gendercontroller.text,
                                qualification: qualificationcontroller.text,
                                categorie: categorycontroller.text,
                                place: placecontroller.text,
                              )),
                    );
                  }
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}

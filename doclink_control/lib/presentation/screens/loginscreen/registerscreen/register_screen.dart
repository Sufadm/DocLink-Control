import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/firestore_service.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';

import '../verificationscreen/verification.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final gender = TextEditingController();
  final qualification = TextEditingController();
  final category = TextEditingController();
  final place = TextEditingController();
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
            child: Column(
              children: [
                kHeight20,
                TextFormFieldWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enetr your name';
                      }
                      return null;
                    },
                    controller: name,
                    hintText: 'Name',
                    icon: Icons.person),
                kHeight10,
                TextFormFieldWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enetr your Gender';
                      }
                      return null;
                    },
                    controller: gender,
                    hintText: 'Gender',
                    icon: Icons.male),
                kHeight10,
                TextFormFieldWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enetr your Qualifiacation';
                      }
                      return null;
                    },
                    controller: qualification,
                    hintText: 'Qualifiacation',
                    icon: Icons.school),
                kHeight10,
                TextFormFieldWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enetr your Categorie';
                      }
                      return null;
                    },
                    controller: category,
                    hintText: 'Categorie',
                    icon: Icons.category),
                kHeight10,
                TextFormFieldWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enetr your Place';
                      }
                      return null;
                    },
                    controller: place,
                    hintText: 'Place',
                    icon: Icons.location_on),
                const SizedBox(
                  height: 25,
                ),
                CustomElevatedButtons(
                  text: 'Next',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirestoreService.saveDetailsToFirestore((documentId) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return VerificationScreen();
                        }));
                      }, (error) {
                        print('Error saving details to Firestore: $error');
                      },
                          name: name.text,
                          gender: gender.text,
                          qualification: qualification.text,
                          category: category.text,
                          place: place.text);
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

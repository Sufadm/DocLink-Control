import 'package:doclink_control/models/prescription_add_model.dart';
import 'package:doclink_control/service/prescription_service.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PrescriptionAddPage extends StatelessWidget {
  final TextEditingController drugController = TextEditingController();
  final TextEditingController usageDurationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PrescriptionAddPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Center(
                    child: Text(
                      'New Prescription',
                      style: kTextStyleLargeBlack,
                    ),
                  ),
                  kHeight25,
                  TextFormFieldWidget(
                    hintText: 'Drug',
                    icon: Icons.abc,
                    controller: drugController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please prescribe Drug';
                      }
                      return null;
                    },
                  ),
                  kHeight10,
                  TextFormFieldWidget(
                      controller: usageDurationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please prescribe UsageDuration';
                        }
                        return null;
                      },
                      hintText: 'Usage Duration',
                      icon: Icons.abc),
                  kHeight10,
                  TextFormFieldWidget(
                      controller: durationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please prescribe Duration';
                        }
                        return null;
                      },
                      hintText: 'Duration',
                      icon: Icons.abc),
                  kHeight10,
                  TextFormField(
                    controller: remarksController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please prescribe Remarks';
                      }
                      return null;
                    },
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: kDarkBlueButtonsColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color:
                              kDarkBlueButtonsColor, // Change to your desired border color
                        ),
                      ),
                      hintText: 'Remarks',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButtons(
                      text: 'Add',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final prescriptionlist = PrescriptionModel(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              drug: drugController.text,
                              usageDuration: usageDurationController.text,
                              duration: durationController.text,
                              remarks: remarksController.text);
                          FirestorePrescriptionService()
                              .addprecription(prescriptionlist)
                              .then((_) => Navigator.pop(context));
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

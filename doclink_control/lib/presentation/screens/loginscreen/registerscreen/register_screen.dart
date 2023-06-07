import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/verificationscreen/verification.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        text: 'Register A Doctor',
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight20,
              const TextFormFieldWidget(hintText: 'Name', icon: Icons.person),
              kHeight10,
              const TextFormFieldWidget(hintText: 'Gender', icon: Icons.male),
              kHeight10,
              const TextFormFieldWidget(
                  hintText: 'Qualifiacation', icon: Icons.school),
              kHeight10,
              const TextFormFieldWidget(
                  hintText: 'Categorie', icon: Icons.category),
              kHeight10,
              const TextFormFieldWidget(
                  hintText: 'Place', icon: Icons.location_on),
              const SizedBox(
                height: 395,
              ),
              CustomElevatedButtons(
                text: 'Next',
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const VerificationScreen();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

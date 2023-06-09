import 'package:doclink_control/const/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../service/auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthService _auth = AuthService();
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email',
                    style: kTextStyleLargeBlack,
                  ),
                  kHeight10,
                  TextFormField(
                    validator: validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    // validator: (value) =>
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: ' Enter Email',
                      hintStyle: GoogleFonts.lato(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color:
                              kDarkBlueButtonsColor, // Change to your desired border color
                        ),
                      ),
                      // contentPadding: const EdgeInsets.symmetric(vertical: 17),
                    ),
                  ),
                  kHeight10,
                  Center(
                      child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          resetPassword(context);
                        },
                        child: const Text('Reset Password')),
                  ))
                ]),
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (formkey.currentState?.validate() ?? false) {
      try {
        await _auth.auth
            .sendPasswordResetEmail(email: emailcontroller.text.trim());
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Password Reset email sent.',
              style: kTextStyleMediumBlack,
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send Reset email. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
        // print(e.toString());
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }
}

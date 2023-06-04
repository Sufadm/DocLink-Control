import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text(
                    'Welcome',
                    style: GoogleFonts.acme(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                Text(
                  'Doctor Login',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 32),
                ),
                kHeight10,
                Text(
                  'Hello Doctor Please Login,if you are already Register',
                  style: GoogleFonts.lato(color: Colors.grey),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Email',
                  style: kTextStyleLargeBlack,
                ),
                kHeight10,
                const TextFormFieldWidget(
                    hintText: 'Enter your Email', icon: Icons.email),
                kHeight10,
                Text(
                  'Password',
                  style: kTextStyleLargeBlack,
                ),
                kHeight10,
                const TextFormFieldWidget(
                    hintText: 'Enter your password', icon: Icons.lock),
                Container(
                  margin: const EdgeInsets.only(left: 250),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password',
                      style: GoogleFonts.lato(
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                ElevatedButtons(
                  onPressed: () {},
                  text: 'Login',
                ),
                Container(
                  margin: const EdgeInsets.only(left: 300),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register',
                      style: GoogleFonts.lato(
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/registerscreen/register_screen.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  final AuthService _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Center(
                    child: Text(
                      'Welcome',
                      style: GoogleFonts.acme(
                        fontSize: screenHeight * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  Text(
                    'Doctor Login',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: screenHeight * 0.045,
                    ),
                  ),
                  kHeight10,
                  Text(
                    'Hello Doctor, Please Login if you are already registered',
                    style: GoogleFonts.lato(color: Colors.grey),
                  ),
                  SizedBox(
                    height: screenHeight * 0.07,
                  ),
                  Text(
                    'Email',
                    style: kTextStyleLargeBlack,
                  ),
                  kHeight10,
                  TextFormFieldWidget(
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter E mail' : null,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    hintText: 'Enter your Email',
                    icon: Icons.email,
                  ),
                  kHeight10,
                  Text(
                    'Password',
                    style: kTextStyleLargeBlack,
                  ),
                  kHeight10,
                  TextFormFieldWidget(
                    validator: (value) =>
                        value!.length < 6 ? 'Please Enter password' : null,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    // val!.isEmpty ? 'Please enter E mail' : null,
                    hintText: 'Enter your password',
                    icon: Icons.lock,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.59),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password',
                        style: GoogleFonts.lato(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  CustomElevatedButtons(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result =
                            await _auth.signEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Wrong email and password';
                            loading = false;
                          });
                        }
                      }
                    },
                    text: 'Login',
                  ),
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.7),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RegisterScreen();
                        }));
                      },
                      child: Text(
                        'Register',
                        style: GoogleFonts.lato(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

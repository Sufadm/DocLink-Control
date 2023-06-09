import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/registerscreen/register_screen.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/provider/auth_provider/auth_provider.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../homescreen/homescreen.dart';
import 'forgotpasswordpage/forgotpassword_page.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthService _auth = AuthService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  //?textformfield widget----------------------------------------
                  TextFormFieldWidget(
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter E mail' : null,
                    onChanged: (value) =>
                        Provider.of<LoginModel>(context, listen: false)
                            .updateEmail(value),
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
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 3 ? 'Please enter a password' : null,
                    onChanged: (value) =>
                        Provider.of<LoginModel>(context, listen: false)
                            .updatePassword(value),
                    hintText: 'Enter your password',
                    icon: Icons.lock,
                  ),
                  //?forgot password--------------------------------
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.59),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }));
                      },
                      child: Text(
                        'Forgot password',
                        style: GoogleFonts.lato(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  //?loginbutton-------------------------------------------------
                  Consumer<LoginModel>(
                    builder: (context, loginModel, _) => CustomElevatedButtons(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          loginModel.setLoading(true);
                          dynamic result = await _auth.signEmailAndPassword(
                              loginModel.email, loginModel.password);
                          if (result == null) {
                            loginModel.setError(
                                'Email and password combination not found. Please register.');
                            loginModel.setLoading(false);
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          }
                        }
                      },
                      text: 'Login',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //?error message--
                  Consumer<LoginModel>(
                    builder: (context, loginModel, _) => Visibility(
                      visible: loginModel.error.isNotEmpty,
                      child: Text(
                        loginModel.error,
                        style: GoogleFonts.lato(color: Colors.red),
                      ),
                    ),
                  ),
                  //?register button--
                  Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.7),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
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

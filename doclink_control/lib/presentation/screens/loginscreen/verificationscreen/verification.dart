import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/homescreen/homescreen.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/provider/auth_provider/register_auth_provider.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: const CustomAppBar(
          text: 'Hello, Sufad M',
        ),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Form(
            key: _formKey,
            child: Consumer<RegisterModel>(
              builder: (context, registerModel, _) {
                return ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    registerModel.photo?.path == null
                        ? Center(
                            child: SizedBox(
                              height: screenHeight * 0.18,
                              width: screenHeight * 0.18,
                              child: Image.network(
                                'https://media.istockphoto.com/id/1189304032/photo/doctor-holding-digital-tablet-at-meeting-room.jpg?s=612x612&w=0&k=20&c=RtQn8w_vhzGYbflSa1B5ea9Ji70O8wHpSgGBSh0anUg=',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Center(
                            child: Container(
                              height: screenHeight * 0.17,
                              width: screenHeight * 0.17,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(screenHeight * 0.085),
                              ),
                              child: Image.file(
                                registerModel.photo!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: screenHeight * 0.010,
                    ),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          if (registerModel.photo == null) {
                            registerModel.setError('');
                          }
                          registerModel.getPhoto(context);
                        },
                        icon: const Icon(
                          Icons.image_outlined,
                        ),
                        label: const Text(
                          'Add An Image',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        if (!isValidEmail(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      hintText: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: registerModel.updateEmail,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter PhoneNumber';
                        }
                        return null;
                      },
                      hintText: 'Phone No',
                      icon: Icons.phone,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      onChanged: registerModel.phonenumber,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                      hintText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      onChanged: registerModel.updatePassword,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Confirm Password';
                        }
                        if (value != registerModel.password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      hintText: 'Confirm Password',
                      icon: Icons.lock,
                      obscureText: true,
                      onChanged: registerModel.updatePasswordagain,
                    ),
                    SizedBox(
                      height: screenHeight * 0.10,
                    ),
                    CustomElevatedButtons(
                      text: 'Submit',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          registerModel.setLoading(true);
                          try {
                            dynamic result =
                                await _auth.resgisterwithEmailAndPaswword(
                              registerModel.email,
                              registerModel.password,
                            );
                            if (result == null) {
                              registerModel.setError(
                                  'An error occurred during registration.');
                              registerModel.setLoading(false);
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const HomeScreen();
                              }));
                            }
                          } catch (error) {
                            registerModel.setError(error.toString());
                            registerModel.setLoading(false);
                          }
                        }
                      },

                      // onPressed: () async {
                      //   if (_formKey.currentState!.validate()) {
                      //     registerModel.setLoading(true);
                      //     dynamic result =
                      //         await _auth.resgisterwithEmailAndPaswword(
                      //       registerModel.email,
                      //       registerModel.password,
                      //     );
                      //     if (result == null) {
                      //       registerModel.setError('Enter a Valid Email');
                      //       registerModel.setLoading(false);
                      //     }  else {
                      //       // ignore: use_build_context_synchronously
                      //       Navigator.pushReplacement(context,
                      //           MaterialPageRoute(builder: (context) {
                      //         return const HomeScreen();
                      //       }));
                      //     }
                      //   }
                      // },
                    ),
                    kHeight10,
                    if (registerModel.error.isNotEmpty)
                      Text(registerModel.error,
                          style: GoogleFonts.lato(color: Colors.red)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Use a regular expression to validate email format
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }
}

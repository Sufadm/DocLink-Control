import 'package:doclink_control/models/profilemodel.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/presentation/screens/homescreen/homescreen.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/provider/auth_provider/register_auth_provider.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:doclink_control/service/firestore_service.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VerificationScreen extends StatelessWidget {
  final String name;
  final String gender;
  final String qualification;
  final String categorie;
  final String place;
  final String? email;
  final String? phone;
  VerificationScreen(
      {Key? key,
      required this.name,
      required this.gender,
      required this.qualification,
      required this.categorie,
      required this.place,
      this.email,
      this.phone})
      : super(key: key);

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
            //?consumer builder provider------------
            child: Consumer<RegisterModel>(
              builder: (context, registerModel, _) {
                return ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),

                    //?image widget------------------
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

                    //?textformfield---
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
                    //?submit button--------------------------------------------
                    registerModel.loading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomElevatedButtons(
                            text: 'Submit',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusScopeNode currentfocus =
                                    FocusScope.of(context);
                                if (!currentfocus.hasPrimaryFocus) {
                                  currentfocus.unfocus();
                                }
                                registerModel.loading = true;
                                try {
                                  dynamic result =
                                      await _auth.resgisterwithEmailAndPaswword(
                                    registerModel.email,
                                    registerModel.password,
                                  );
                                  if (result == null) {
                                    registerModel.setError(
                                        'An error occurred during registration.');
                                    registerModel.loading = false;
                                  } else {
                                    String imageUrl = '';
                                    if (registerModel.photo != null) {
                                      imageUrl = await FirestoreService()
                                          .uploadImageToStorage(
                                              registerModel.photo!);
                                    }
                                    final fcmToken = await FirebaseMessaging
                                        .instance
                                        .getToken();

                                    final user = ProfileModel(
                                        fcmToken: fcmToken!,
                                        //  fcmToken: fcmToken!,
                                        uid: _auth.auth.currentUser!.uid,
                                        imageUrl: imageUrl,
                                        email: registerModel.email,
                                        phone: registerModel.phoneNumber,
                                        name: name,
                                        gender: gender,
                                        qualification: qualification,
                                        category: categorie,
                                        place: place);
                                    FirestoreService()
                                        .createUser(user)
                                        .then((_) {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const HomeScreen();
                                      }));
                                    });

                                    // ignore: use_build_context_synchronously
                                  }
                                  registerModel.loading = false;
                                } catch (error) {
                                  registerModel.setError(error.toString());

                                  registerModel.loading = false;
                                }
                              }
                            },
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

//?email format function--------------------------------------------------------
  bool isValidEmail(String email) {
    // Use a regular expression to validate email format
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }
}

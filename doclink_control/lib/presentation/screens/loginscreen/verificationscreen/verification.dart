import 'dart:io';

import 'package:doclink_control/presentation/screens/homescreen/homescreen.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../provider/photprovider/photoprovider.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final AuthService _auth = AuthService();
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String error = '';
  String email = '';
  String password = '';
  String confirmpassword = '';
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider<PhotoProvider>(
      create: (_) => PhotoProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(
          text: 'Hello, Sufad M',
        ),
        body: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Form(
            key: _formKey,
            child: Consumer<PhotoProvider>(
              builder: (context, photoProvider, _) {
                return ListView(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    photoProvider.photo?.path == null
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
                                photoProvider.photo!,
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
                          if (photoProvider.photo == null) {
                            setState(() {
                              error = '';
                            });
                            return;
                          }
                          getPhoto(context);
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
                        return null;
                      },
                      hintText: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
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
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
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
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    TextFormFieldWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Confirm Password';
                        }
                        if (value != password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      hintText: 'Confirm Password',
                      icon: Icons.lock,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          confirmpassword = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.10,
                    ),
                    CustomElevatedButtons(
                      text: 'Submit',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .resgisterwithEmailAndPaswword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Enter a Valid Email';
                              loading = false;
                            });
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const HomeScreen();
                            }));
                          }
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getPhoto(BuildContext context) async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      // ignore: use_build_context_synchronously
      Provider.of<PhotoProvider>(context, listen: false).setPhoto(photoTemp);
    }
  }
}

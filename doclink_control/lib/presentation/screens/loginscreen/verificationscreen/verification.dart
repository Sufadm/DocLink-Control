import 'dart:io';

import 'package:doclink_control/presentation/screens/homescreen/homescreen.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../provider/photprovider/photoprovider.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

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
                    const TextFormFieldWidget(
                      hintText: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const TextFormFieldWidget(
                      hintText: 'Phone No',
                      icon: Icons.phone,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const TextFormFieldWidget(
                      hintText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    const TextFormFieldWidget(
                      hintText: 'Confirm Password',
                      icon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: screenHeight * 0.20,
                    ),
                    CustomElevatedButtons(
                      text: 'Submit',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen();
                        }));
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

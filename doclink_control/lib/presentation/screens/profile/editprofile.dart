import 'package:doclink_control/provider/auth_provider/editprofile_provider.dart';
import 'package:doclink_control/service/firestore_service.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/profilemodel.dart';
import '../loginscreen/widgets/textformfield_widget.dart';

class EditProfile extends StatelessWidget {
  final String imageUrl;
  final Map<String, dynamic> profileData;
  final TextEditingController genderController;
  final TextEditingController nameController;
  final TextEditingController qualificationController;
  final TextEditingController categoryController;
  final TextEditingController emailController;
  final TextEditingController placeController;
  final TextEditingController phonenumberController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditProfile({
    Key? key,
    required this.profileData,
    required this.imageUrl,
  })  : nameController = TextEditingController(text: profileData['name'] ?? ''),
        qualificationController =
            TextEditingController(text: profileData['qualification'] ?? ''),
        categoryController =
            TextEditingController(text: profileData['category'] ?? ''),
        emailController =
            TextEditingController(text: profileData['email'] ?? ''),
        placeController =
            TextEditingController(text: profileData['place'] ?? ''),
        phonenumberController =
            TextEditingController(text: profileData['phone'] ?? ''),
        genderController =
            TextEditingController(text: profileData['gender'] ?? ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider<EditProfileProvider>(
      create: (context) => EditProfileProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(text: 'Profile'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Consumer<EditProfileProvider>(
              builder: (context, editProfileProvider, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      editProfileProvider.photo == null
                          ? Center(
                              child: SizedBox(
                                height: screenHeight * 0.18,
                                width: screenHeight * 0.18,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Center(
                              child: Container(
                                height: screenHeight * 0.17,
                                width: screenHeight * 0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      screenHeight * 0.085),
                                ),
                                child: Image.file(
                                  editProfileProvider.photo!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      kHeight10,
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          editProfileProvider.getPhoto(context);
                        },
                        icon: const Icon(Icons.image_outlined),
                        label: const Text('Add An Image'),
                      ),
                      kHeight15,
                      TextFormFieldWidget(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                        hintText: 'Name',
                        icon: Icons.abc,
                        keyboardType: TextInputType.emailAddress,
                        controller: nameController,
                      ),
                      kHeight10,
                      TextFormFieldWidget(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        hintText: 'Email',
                        icon: Icons.email,
                      ),
                      kHeight10,
                      TextFormFieldWidget(
                        controller: genderController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Gender';
                          }
                          return null;
                        },
                        hintText: 'Gender',
                        icon: Icons.email,
                      ),
                      kHeight10,
                      TextFormFieldWidget(
                        controller: qualificationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter qualification';
                          }
                          return null;
                        },
                        hintText: 'qualification',
                        icon: Icons.school,
                      ),
                      kHeight10,
                      TextFormFieldWidget(
                        controller: categoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Category';
                          }
                          return null;
                        },
                        hintText: 'Category',
                        icon: Icons.category,
                      ),
                      kHeight10,
                      TextFormFieldWidget(
                        controller: phonenumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter PhoneNumber';
                          }
                          return null;
                        },
                        hintText: 'phoneNumber',
                        icon: Icons.phone_iphone,
                      ),
                      kHeight10,
                      TextFormFieldWidget(
                        controller: placeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Place';
                          }
                          return null;
                        },
                        hintText: 'Place',
                        icon: Icons.place,
                      ),
                      kHeight25,
                      CustomElevatedButtons(
                        text: 'Save',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final editProfileProvider =
                                Provider.of<EditProfileProvider>(context,
                                    listen: false);

                            // Upload image if a new image is selected
                            String imageUrl = '';
                            if (editProfileProvider.photo != null) {
                              imageUrl = await FirestoreService()
                                  .uploadImageToStorage(
                                      editProfileProvider.photo!);
                              editProfileProvider.photo;
                            }

                            // Update user data
                            ProfileModel updatedUser = ProfileModel(
                              uid: FirestoreService().getCurrentUserId(),
                              name: nameController.text,
                              qualification: qualificationController.text,
                              category: categoryController.text,
                              place: placeController
                                  .text, // Add the logic to get the place value
                              imageUrl: imageUrl,
                              email: emailController.text,
                              phone: phonenumberController.text,
                              gender: genderController
                                  .text, // Add the logic to get the phone value
                            );
                            await FirestoreService().updateUser(updatedUser);

                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

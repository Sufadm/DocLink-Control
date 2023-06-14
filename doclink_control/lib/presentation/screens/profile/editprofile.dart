import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/widgets/appbar_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';

import '../loginscreen/widgets/textformfield_widget.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                  'https://media.istockphoto.com/id/1189304032/photo/doctor-holding-digital-tablet-at-meeting-room.jpg?s=612x612&w=0&k=20&c=RtQn8w_vhzGYbflSa1B5ea9Ji70O8wHpSgGBSh0anUg=',
                  fit: BoxFit.cover,
                ),
              ),
              kHeight10,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.image_outlined,
                ),
                label: const Text(
                  'Add An Image',
                ),
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
                //onChanged: registerModel.updateEmail,
              ),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter qualification';
                    }
                    return null;
                  },
                  hintText: 'qualification',
                  icon: Icons.school),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Categorie';
                    }
                    return null;
                  },
                  hintText: 'Categorie',
                  icon: Icons.category),
              kHeight10,
              TextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter PhoneNumber';
                    }
                    return null;
                  },
                  hintText: 'PhoneNumber',
                  icon: Icons.phone),
              kHeight25,
              CustomElevatedButtons(
                  text: 'Save',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

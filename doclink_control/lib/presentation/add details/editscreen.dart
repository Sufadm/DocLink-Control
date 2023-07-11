import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/adddetails_service.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditScreen extends StatelessWidget {
  final Map<String, dynamic> profileData;

  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final TextEditingController timeperPersonController;
  final TextEditingController appointmentFeeController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditScreen({
    Key? key,
    required this.profileData,
  })  : startTimeController =
            TextEditingController(text: profileData['startTime'] ?? ''),
        endTimeController =
            TextEditingController(text: profileData['endTime'] ?? ''),
        timeperPersonController =
            TextEditingController(text: profileData['timePerPerson'] ?? ''),
        appointmentFeeController =
            TextEditingController(text: profileData['fee'] ?? ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    void selectedTime() async {
      final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          useRootNavigator: false,
          initialEntryMode: TimePickerEntryMode.input);
      if (pickedTime != null) {
        String formattedTime = DateFormat('hh:mm a').format(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        ));
        startTimeController.text = formattedTime;
      }
    }

    void selectEndTime() async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        useRootNavigator: false,
        initialEntryMode: TimePickerEntryMode.input,
      );
      if (pickedTime != null) {
        String formattedTime = DateFormat('hh:mm a').format(DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          pickedTime.hour,
          pickedTime.minute,
        ));
        endTimeController.text = formattedTime;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlueButtonsColor,
        title: const Text('EditScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'START TIME',
                style: GoogleFonts.outfit(),
              ),
              kHeight10,
              TextFormFieldWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your Time';
                  }
                  return null;
                },
                controller: startTimeController,
                ontap: () => selectedTime(),
                hintText: 'start',
                icon: Icons.access_time,
              ),
              kHeight10,
              Text(
                'End TIME',
                style: GoogleFonts.outfit(),
              ),
              kHeight10,
              TextFormFieldWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your Time';
                  }
                  return null;
                },
                controller: endTimeController,
                ontap: () => selectEndTime(),
                hintText: 'End',
                icon: Icons.access_time,
              ),
              kHeight10,
              Text(
                'TimePerPerson',
                style: GoogleFonts.outfit(),
              ),
              kHeight10,
              TextFormFieldWidget(
                controller: timeperPersonController,
                hintText: 'TimePerPerson',
                icon: Icons.abc,
              ),
              kHeight10,
              Text(
                'AppointmentFee',
                style: GoogleFonts.outfit(),
              ),
              kHeight10,
              TextFormFieldWidget(
                controller: appointmentFeeController,
                hintText: 'AppointmentFee',
                icon: Icons.abc,
              ),
              kHeight15,
              CustomElevatedButtons(
                text: 'Save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedData = {
                      'startTime': startTimeController.text,
                      'endTime': endTimeController.text,
                      'timePerPerson': timeperPersonController.text,
                      'fee': appointmentFeeController.text,
                    };

                    final FirestoreAddDetailService firestoreService =
                        FirestoreAddDetailService();
                    firestoreService
                        .updateDetail(
                            FirebaseAuth.instance.currentUser!.uid, updatedData)
                        .then((_) {
                      // Handle success or display a success message
                    }).catchError((error) {
                      // Handle error or display an error message
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

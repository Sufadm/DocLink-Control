import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:doclink_control/models/adddetail_model.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/adddetails_service.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'alldetails.dart';

class AddDetailPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController feeController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();
    TextEditingController timePerPersonController = TextEditingController();

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
        timeController.text = formattedTime;
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
      appBar: const CustomAppBar(
        text: 'Add Details',
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style: kTextStyleLargeBlack,
                ),
                kHeight25,
                DatePicker(
                  DateTime.now(),
                  activeDates: [
                    DateTime.now(),
                  ],
                  daysCount: 10,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    AppointmentDateProvider().setDate(date);
                  },
                ),
                kHeight25,
                Text(
                  '    Time',
                  style: kTextStyleMediumBlack,
                ),
                kHeight5,
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 155,
                        child: TextFormFieldWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your Time';
                            }
                            return null;
                          },
                          controller: timeController,
                          ontap: () => selectedTime(),
                          hintText: 'start',
                          icon: Icons.access_time,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('to'),
                      kWidth10,
                      SizedBox(
                        width: 155,
                        child: TextFormFieldWidget(
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
                      ),
                    ],
                  ),
                ),
                kHeight5,
                TextFormFieldWidget(
                  controller: timePerPersonController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your Time';
                    }
                    return null;
                  },
                  hintText: 'Time per person',
                  icon: Icons.access_time,
                ),
                kHeight10,
                TextFormFieldWidget(
                  controller: feeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your fee';
                    }
                    return null;
                  },
                  hintText: 'Appointment Fee',
                  icon: Icons.money,
                ),
                kHeight15,
                Center(
                  child: CustomElevatedButtons(
                      text: 'Add',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final currentDate = DateTime.now();
                          final formattedCurrentDate =
                              DateFormat('yyyy-MM-dd').format(currentDate);
                          DateTime? selectedDate =
                              AppointmentDateProvider().getDate();
                          AddDetailModel user = AddDetailModel(
                              date: formattedCurrentDate,
                              endTime: endTimeController.text,
                              startTime: timeController.text,
                              uid: FirestoreAddDetailService()
                                  .getCurrentUserId(),
                              fee: feeController.text,
                              timePerPerson: timePerPersonController.text);
                          FirestoreAddDetailService()
                              .addDetailService(user)
                              .then((_) {});
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TimeDetails(
                              doctorId: FirebaseAuth.instance.currentUser!.uid,
                            );
                          }));
                        }
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 290),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TimeDetails(
                              doctorId: FirebaseAuth.instance.currentUser!.uid);
                        }));
                      },
                      child: Text(
                        'All Details',
                        style: GoogleFonts.lato(
                            decoration: TextDecoration.underline),
                      )),
                ),
                kHeight10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentDateProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  DateTime? getDate() {
    return selectedDate;
  }
}

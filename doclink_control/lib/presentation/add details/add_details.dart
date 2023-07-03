import 'package:doclink_control/models/adddetail_model.dart';
import 'package:doclink_control/presentation/add%20details/alldetails.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/adddetails_service.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddDetailPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController timeController = TextEditingController();
    TextEditingController placeController = TextEditingController();

    TextEditingController feeController = TextEditingController();

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

    return Scaffold(
      appBar: const CustomAppBar(
        text: 'Add Details',
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            children: [
              kHeight10,
              TextFormFieldWidget(
                  controller: placeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Place';
                    }
                    return null;
                  },
                  hintText: 'Place',
                  icon: (Icons.place)),
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
              kHeight10,
              TextFormFieldWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your Time';
                  }
                  return null;
                },
                controller: timeController,
                ontap: () => selectedTime(),
                hintText: 'Time',
                icon: Icons.access_time,
              ),
              kHeight15,
              CustomElevatedButtons(
                  text: 'Add',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AddDetailModel user = AddDetailModel(
                          place: placeController.text,
                          time: timeController.text,
                          uid: FirestoreAddDetailService().getCurrentUserId(),
                          fee: feeController.text);
                      FirestoreAddDetailService()
                          .addDetailService(user)
                          .then((_) {});
                      Navigator.pop(context);
                    }
                  }),
              Container(
                margin: const EdgeInsets.only(left: 270),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AllDetail();
                      }));
                    },
                    child: Text(
                      'AllDetails',
                      style: GoogleFonts.lato(
                          decoration: TextDecoration.underline),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:doclink_control/models/adddetail_model.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/service/adddetails_service.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service/auth.dart';

class AddDetailPage extends StatelessWidget {
  final AuthService _auth = AuthService();

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

    return StreamBuilder(
      stream: FirestoreAddDetailService().getDetailsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var document = snapshot.data;

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

                      //     kHeight10,
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
                        icon: Icons.money,
                      ),
                      kHeight15,

                      CustomElevatedButtons(
                          text: 'Add',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final user = AddDetailModel(
                                  place: placeController.text,
                                  time: timeController.text,
                                  uid: _auth.auth.currentUser!.uid,
                                  fee: feeController.text);
                              FirestoreAddDetailService()
                                  .addDetailService(user)
                                  .then((_) {});
                            }
                          }),

                      kHeight25,
                      Expanded(
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 110,
                                width: double.infinity,
                                color: greylight1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Place :  ${document!['place']}',
                                        style: kTextStyleMediumBlack,
                                      ),
                                      Text(
                                        ' Fee :  ${document['fee']}',
                                        style: kTextStyleMediumBlack,
                                      ),
                                      Text(
                                        'Time :  ${document['time']}',
                                        style: kTextStyleMediumBlack,
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}

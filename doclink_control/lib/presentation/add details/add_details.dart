import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/shared/appbar_widget.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/shared/elevatedbuttonss.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddDetailPage extends StatelessWidget {
  const AddDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController timeController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          children: [
            kHeight10,
            const TextFormFieldWidget(hintText: 'Place', icon: (Icons.place)),
            kHeight10,

            //     kHeight10,
            const TextFormFieldWidget(
              hintText: 'Appointment Fee',
              icon: Icons.money,
            ),
            kHeight10,
            TextFormFieldWidget(
              controller: timeController,
              ontap: () => selectedTime(),
              hintText: 'Time',
              icon: Icons.money,
            ),
            kHeight15,

            CustomElevatedButtons(text: 'Add', onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}

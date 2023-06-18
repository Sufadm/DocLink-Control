import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/loginscreen/widgets/textformfield_widget.dart';
import 'package:doclink_control/widgets/elevatedbuttonss.dart';
import 'package:flutter/material.dart';

class PrescriptionAddPage extends StatelessWidget {
  const PrescriptionAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Center(
                  child: Text(
                    'New Prescription',
                    style: kTextStyleLargeBlack,
                  ),
                ),
                kHeight25,
                const TextFormFieldWidget(hintText: 'Drug', icon: Icons.abc),
                kHeight10,
                const TextFormFieldWidget(
                    hintText: 'Usage Duration', icon: Icons.abc),
                kHeight10,
                const TextFormFieldWidget(
                    hintText: 'Duration', icon: Icons.abc),
                kHeight10,
                TextFormField(
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: kDarkBlueButtonsColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color:
                            kDarkBlueButtonsColor, // Change to your desired border color
                      ),
                    ),
                    hintText: 'Remarks',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 340,
                ),
                CustomElevatedButtons(
                    text: 'Add',
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

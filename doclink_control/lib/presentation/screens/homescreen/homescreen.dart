import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:flutter/material.dart';

import '../loginscreen/loginscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.notifications)),
                ],
              ),
              kHeight20,
              Center(
                child: Text(
                  'HELLO, Dr.Sufad M',
                  style: kTextStyleLargeBlack.copyWith(
                      fontSize: screenWidth * 0.05),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              SearchBar(
                hintText: 'Search your patient',
                leading: Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.02),
                  child: const Icon(Icons.search),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Today\'s Appointments',
                style: kTextStyleLargeBlack.copyWith(
                    fontSize: screenWidth * 0.055),
              ),
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: screenWidth * 0.017,
                    mainAxisSpacing: screenHeight * 0.017,
                  ),
                  itemCount: 2, // Replace with the actual number of items
                  itemBuilder: (context, index) {
                    return Container(
                      color: greylight1,
                      child: Center(
                        child: Text(
                          'Patient ${index + 1}',
                          style: kTextStyleMediumBlack.copyWith(
                              fontSize: screenWidth * 0.04),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await auth.logout();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text('signout'))
            ],
          ),
        ),
      ),
    );
  }
}

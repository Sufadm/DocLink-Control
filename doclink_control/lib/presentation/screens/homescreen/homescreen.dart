import 'package:doclink_control/const/const.dart';
import 'package:doclink_control/presentation/screens/homescreen/widgets/drawer_widget.dart';
import 'package:doclink_control/presentation/screens/homescreen/widgets/gridview_widget.dart';
import 'package:flutter/material.dart';

import '../notification_details/notification_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawerwidget(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(Icons.menu)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const NotificationPage();
                            }));
                          },
                          icon: const Icon(Icons.notifications)),
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
                  GridViewWidget(
                      screenWidth: screenWidth, screenHeight: screenHeight),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

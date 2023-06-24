import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doclink_control/service/firestore_service.dart';
import 'package:doclink_control/shared/const/const.dart';
import 'package:doclink_control/presentation/screens/homescreen/drawer/drawer_widget.dart';
import 'package:doclink_control/presentation/screens/homescreen/widgets/gridview_widget.dart';
import 'package:flutter/material.dart';
import '../../../shared/textwidget.dart';
import '../notification_details/notification_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirestoreService().getProfileStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var document = snapshot.data;
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
                          //?drawer and notification widget-------------------------
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
                              'Hello Dr. ${document!['name']}',
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
                          HeadingTextWidget(
                            screenWidth: screenWidth,
                            text: 'Today\'s Appointments',
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          //?grid view widget--
                          GridViewWidget(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const Text('Error');
          }
        }
        return Container();
      },
    );
  }
}

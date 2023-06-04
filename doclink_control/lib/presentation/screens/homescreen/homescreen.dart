import 'package:doclink_control/const/const.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                const Icon(Icons.notifications)
              ],
            ),
            Center(
              child: Text(
                'HELLO, Dr.Sufad M',
                style: kTextStyleLargeBlack,
              ),
            ),
            kHeight25,
            SearchBar(
              hintText: 'Search your patient',
              leading: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Icon(Icons.search)),
            ),
            Text(
              'Todays Appointments',
              style: kTextStyleLargeBlack,
            )
          ],
        ),
      ),
    );
  }
}

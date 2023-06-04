import 'package:doclink_control/const/const.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  child: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Today\'s Appointments',
                style: kTextStyleLargeBlack,
              ),
              kHeight10,
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 2, // Replace with the actual number of items
                  itemBuilder: (context, index) {
                    return Container(
                      color: greylight1,
                      child: Center(
                          child: Text(
                        'Patient 1',
                        style: kTextStyleMediumBlack,
                      )),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

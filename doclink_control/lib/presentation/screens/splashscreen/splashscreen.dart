import 'package:doclink_control/models/user.dart';
import 'package:doclink_control/presentation/screens/loginscreen/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../homescreen/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.repeat(reverse: false);

    navigateToHomeScreen();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  navigateToHomeScreen() async {
    await Future.delayed(const Duration(milliseconds: 2600));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Wrapper();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 45, 81),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                "asset_images/online-doctor-consultation-flat-design-logo-aplication-doctor-cartoon-for-mobile-app-free-vector-removebg-preview (1).png", // Replace with your logo image path
                width: 220,
                height: 220,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'DocLink Control',
              style: GoogleFonts.lato(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();

      //return either home or authenticate widget
    }
  }
}

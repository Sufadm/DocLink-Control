import 'package:doclink_control/models/user.dart';
import 'package:doclink_control/presentation/screens/splashscreen/splashscreen.dart';
import 'package:doclink_control/provider/auth_provider/auth_provider.dart';
import 'package:doclink_control/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().userlog,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DocLink Control',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

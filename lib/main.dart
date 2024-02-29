import 'package:email_vertify/views/home_screen/home_screen.dart';
import 'package:email_vertify/views/log_in_screen/log_in_screen.dart';
import 'package:email_vertify/views/sign_up_screen_view.dart/sign_up_screen.dart';
<<<<<<< HEAD
import 'package:email_vertify/views/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
import 'package:email_vertify/views/Terms_of_service_screen/terms_of_service_screen.dart';
>>>>>>> 132e0defb4d9a7d1028fc846d397b1c93b19332d
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.debug);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return signInScreen();
            }
            return const Sign_upScreen();
          },
        ),
=======
    return const MaterialApp(
      home: SignUpScreen(),
>>>>>>> 132e0defb4d9a7d1028fc846d397b1c93b19332d
    );
  }
}

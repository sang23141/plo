import 'package:email_vertify/views/home_screen/home_screen.dart';
import 'package:email_vertify/views/log_in_screen/log_in_screen.dart';
<<<<<<< HEAD
import 'package:firebase_app_check/firebase_app_check.dart';
=======
import 'package:email_vertify/views/splash_screen/splash_screen.dart';
>>>>>>> for_homescreen
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
<<<<<<< HEAD
import 'views/splash_screen/splash_screen.dart';
=======
import 'package:firebase_app_check/firebase_app_check.dart';

import 'views/sign_up_screen_view/sign_up_screen.dart';
>>>>>>> for_homescreen

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
    return MaterialApp(
<<<<<<< HEAD
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const HomeScreen();
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return const signInScreen();
        },
      ),
=======
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return signInScreen();
            }
            return const SignUpScreen();
          },
        ),
>>>>>>> for_homescreen
    );
  }
}

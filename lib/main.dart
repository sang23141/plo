import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/model/auth_requirements/auth_requirement_screen.dart';
import 'package:plo/views/home_screen/home_screen.dart';
import 'package:plo/views/log_in_screen/log_in_screen.dart';
import 'package:plo/views/splash_screen/splash_screen.dart';

import 'firebase_options.dart';

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
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const SplashScreen();
      //     }
      //     if (snapshot.hasData) {
      //       // return const HomeScreen();
      //        return const HomeScreen();
      //     }
      //     // return const SignInScreen();
      //      return const SignInScreen();
      //   },
      // ),
      home: const AuthRequirementScreen()
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/services/utils_services.dart';
import 'package:herewego/pages/signIn_page.dart';
import 'package:herewego/pages/signUp_page.dart';

void main() {
  runApp(
    MaterialApp(
        home: const MyApp(),
        routes: {
      HomePage.id:(context) => const HomePage(),
      SignInPage.id: (context) => const SignInPage(),
      SignUpPage.id: (context) => const SignUpPage(),
    }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const SignInPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Utils.Loading();
      },
    );
  }
}

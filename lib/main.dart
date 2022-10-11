import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/home_page.dart';

import 'package:herewego/pages/signIn_page.dart';
import 'package:herewego/pages/signUp_page.dart';
import 'package:flutter/material.dart';

import 'model/pref_model.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print('Firebase ishga tushti'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  _startPage(),
      routes: {
      HomePage.id:(context) => HomePage(),
        SignInPage.id:(context) => SignInPage(),
        SignUpPage.id:(context) => SignUpPage(),
        DetailPage.id:(context) => DetailPage()

      },
    );
  }

  Widget _startPage(){
    return StreamBuilder <User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,snapshot){
      if(snapshot.hasData){
        Prefs.saveUserId(snapshot.data!.uid);
        return HomePage();
      }
      else{
        Prefs.removeUserId();
        return const SignInPage();
      }
    });
  }
}


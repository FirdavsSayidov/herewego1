import 'package:flutter/material.dart';
import 'package:herewego/pages/services/auth_services.dart';
import 'package:herewego/pages/signIn_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:ElevatedButton(
          child: Text('Button'),
          onPressed: () {
            AuthService.removeUser(context);
            Navigator.pushReplacementNamed(context, SignInPage.id);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red
          ),
        ),
      ),
    );
  }
}

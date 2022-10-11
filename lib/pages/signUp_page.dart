import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signIn_page.dart';
import '../model/pref_model.dart';
import '../services/auth_services.dart';
import '../services/utils_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = 'SignUpPage';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var nameController = TextEditingController();
  var emailController  = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;

  doLogin(){
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
     setState(() {
      isLoading = true;
     });
   AuthService.signUpUser(context, name, email, password).then((firebaseUser) =>
   {
     _getFirebaseUser(firebaseUser),
   });
  }
  void _getFirebaseUser(User? firebaseUser) async {
    setState(() {
      isLoading = false;
    });
    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }
    else{
      Utils.fireToast('check all information');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: nameController,
              decoration: InputDecoration(
                hintText: 'name',

              ),
            ),
            TextField(controller: emailController,
              decoration: InputDecoration(
                hintText: 'email',

              ),
            ),  TextField(obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'password',

              ),
            ),
            isLoading?
            CircularProgressIndicator():
                SizedBox.shrink(),
            SizedBox(height: 20,),
            OutlinedButton(onPressed: (){
                       doLogin();},
              child: Text('SignUp',style: TextStyle(color: Colors.white),),
              style: OutlinedButton.styleFrom(

                  backgroundColor: Colors.blue
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Text('Already have an account?'),
              TextButton(onPressed: (){Navigator.pushNamed(context, SignInPage.id);
              }, child: Text('SignIn'),
              
              )
            ],)
          ],
        ),
      ),
    );
  }
}

import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/google_auth_services/google_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text("Home Page",style:  TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: () async {
          await  AuthService.authService.signOutUser();
          await GoogleAuthServices.googleAuthServices.signOutFromGoogle();

            User? user=AuthService.authService.getCurrentUser();
            if(user==null)
              {
                Get.offAndToNamed('/signIn');
              }
          }, icon: Icon(Icons.login_outlined))
        ],
      ),
    );
  }
}

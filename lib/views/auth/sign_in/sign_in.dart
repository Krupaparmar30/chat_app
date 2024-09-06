//sign in -> log in -> already account

import 'package:chat_app/controllers/auth_controller/auth_controller.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/google_auth_services/google_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_button/sign_in_button.dart';

class signIn extends StatelessWidget {
  const signIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        title: Text("Sign In",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.txtEmail,
              decoration: InputDecoration(
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height:20,
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: InputDecoration(
                  labelText: "Password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/signUp');
                },
                child: Text("Dont have Account? Sing up")),
            ElevatedButton(
                onPressed: () async {
                  //user null
                  String response = await AuthService.authService
                      .signInWithEmailAndPassword(controller.txtEmail.text,
                          controller.txtPassword.text);
                  //user

                  User? user = AuthService.authService.getCurrentUser();
                  if (user != null && response == "success") {
                    Get.offAndToNamed('/home');
                  } else {
                    Get.snackbar('Sign In Failed !', response);
                  }
                },
                child: Text("Sign In")),
            SignInButton(Buttons.google, onPressed: (){


GoogleAuthServices.googleAuthServices.signInWithGoogle();
User? user = AuthService.authService.getCurrentUser();

if (user != null) {
  Get.offAndToNamed('/home');
}

            })
          ],
        ),
      ),
    );
  }
}

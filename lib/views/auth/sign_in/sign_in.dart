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

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 800,
          width: 500,
         color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 150),
            Text(
                "Sign In",
                style: TextStyle(color: Colors.blue.shade800,fontSize: 32,letterSpacing: 1,fontWeight: FontWeight.bold),
              ),
                SizedBox(height: 50),

                TextField(
                  controller: controller.txtEmail,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: Colors.blue.shade900,),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.blue.shade900
                  ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900),

                      ),
                      focusedBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: Colors.blue.shade900),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller.txtPassword,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password,color: Colors.blue.shade900,),

                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.blue.shade900
                      ),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade900),
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/signUp');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text("Dont have Account? Sing up",style: TextStyle(color: Colors.blue.shade900,fontSize: 16)),
                    )),
                SizedBox(
                  height: 20,
                ),
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
              Text("Or",style: TextStyle(color: Colors.blue.shade900,fontSize: 22),),
                SignInButton(Buttons.google, onPressed: () {
                  GoogleAuthServices.googleAuthServices.signInWithGoogle();
                  User? user = AuthService.authService.getCurrentUser();

                  if (user != null) {
                    Get.offAndToNamed('/home');
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

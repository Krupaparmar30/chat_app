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
          height: 900,
          width: 500,

decoration: BoxDecoration(
gradient : LinearGradient(colors: RxList([
Color(0xff0c0f2e),
Color(0xff292b60),



]))
),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(right:100),
                //   child: Container(
                //     width: 200,
                //     height: 200,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(100),
                //       color: Colors.white60
                //     ),
                //   ),
                // ),

                SizedBox(height: 200),
            Text(
                "Sign In",
                style: TextStyle(color: Colors.white,fontSize: 40,letterSpacing: 1,fontWeight: FontWeight.bold),
              ),
                SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: controller.txtEmail,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,color: Colors.white,),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white
                    ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                  
                        ),
                        focusedBorder: OutlineInputBorder(
                  
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),

                    controller: controller.txtPassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password,color: Colors.white,),

                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white
                        ),
                            enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed('/signUp');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text("Dont have Account? Sing up",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing:1.0 )),
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
              Text("Or",style: TextStyle(color: Colors.white,fontSize: 22),),
                SignInButton(Buttons.google, onPressed: () {
                  GoogleAuthServices.googleAuthServices.signInWithGoogle();
                  User? user = AuthService.authService.getCurrentUser();

                  if (user != null) {
                    Get.offAndToNamed('/home');
                  }
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

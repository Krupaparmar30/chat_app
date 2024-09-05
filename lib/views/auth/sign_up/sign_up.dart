//sign in -> log in -> already account

import 'package:chat_app/controllers/auth_controller/auth_controller.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class signUp extends StatelessWidget {
  const signUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        title: Text("Sign Up",style: TextStyle(color: Colors.white),),
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
              height: 20
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
                Get.back();


                }, child: Text("Already have Account? Sing up")),
            ElevatedButton(
                onPressed: () {

                  AuthService.authService.createAccountWithEmailAndPassword(
                      controller.txtEmail.text, controller.txtPassword.text);
Get.back();

                  /////
                  controller.txtEmail.clear();
                  controller.txtPassword.clear();
                },
                child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}

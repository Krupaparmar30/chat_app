//sign in -> log in -> already account

import 'package:chat_app/controllers/auth_controller/auth_controller.dart';
import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
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
        title: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller.txtName,
                decoration: InputDecoration(
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10))),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              TextField(
                controller: controller.txtConfirmPassword,
                decoration: InputDecoration(
                    labelText: "ConfirmPassword",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10))),
              ),
              TextField(
                controller: controller.txtPhone,
                decoration: InputDecoration(
                    labelText: "Phone",
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
                  },
                  child: Text("Already have Account? Sing up")),
              ElevatedButton(
                  onPressed: () {
                    if (controller.txtPassword.text ==
                        controller.txtConfirmPassword.text)
                      AuthService.authService.createAccountWithEmailAndPassword(
                          controller.txtEmail.text, controller.txtPassword.text);
                    UserModalData user = UserModalData(
                        name: controller.txtName.text,
                        email: controller.txtEmail.text,
                        image:
                            "https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp",
                        password: controller.txtPassword.text,
                        phone: controller.txtPhone.text,
                        token: "-------");
                    CloudFireStoreServices.cloudFireStoreServices
                        .insertUserIntoFireStore(user);
                    Get.back();

                    /////
                    controller.txtEmail.clear();
                    controller.txtPassword.clear();
                    controller.txtName.clear();
                    controller.txtConfirmPassword.clear();
                    controller.txtPhone.clear();
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ),
      ),
    );
  }
}

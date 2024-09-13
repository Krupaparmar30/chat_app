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
      // appBar: AppBar(
      //   backgroundColor: Colors.blue.shade800,
      //   centerTitle: true,
      //   title: Text(
      //     "Sign Up",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(

          height: 760,
          width: 500,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  SizedBox(height: 120),
                  Text(
                    "Sign up",
                    style: TextStyle(color: Colors.blue.shade800,fontSize: 32,letterSpacing: 1,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),


                  TextField(
                    controller: controller.txtName,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.blue.shade900,),

                        labelText: "Name",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: controller.txtEmail,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email,color: Colors.blue.shade900,),

                        labelText: "Email",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900),

                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),

                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 15),

                  TextField(
                    controller: controller.txtPassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password,color: Colors.blue.shade900,),

                        labelText: "Password",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900),

                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),

                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: controller.txtConfirmPassword,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password,color: Colors.blue.shade900,),

                        labelText: "ConfirmPassword",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue.shade900),

                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue.shade900),

                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(height: 15),

                  TextField(
                    controller: controller.txtPhone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone,color: Colors.blue.shade900,),

                        labelText: "Phone",
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
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Already have Account? Sing in",style: TextStyle(color: Colors.blue.shade900),)),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.txtPassword.text ==
                            controller.txtConfirmPassword.text)
                          {
                            AuthService.authService.createAccountWithEmailAndPassword(
                                controller.txtEmail.text, controller.txtPassword.text);
                            UserModalData user = UserModalData(
                                name: controller.txtName.text,
                                email: controller.txtEmail.text,
                                image:
                                "https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp",

                                phone: controller.txtPhone.text,
                                token: "-------");
                            CloudFireStoreServices.cloudFireStoreServices
                                .insertUserIntoFireStore(user);
                            Get.offAndToNamed('/home');

                            /////
                            controller.txtEmail.clear();

                            controller.txtName.clear();
                            controller.txtConfirmPassword.clear();
                            controller.txtPhone.clear();

                          }
                        else {
                          Get.snackbar('Sign In Failed !', "Password incorrect ");
                        }


                      },


                      child: Text("Sign Up"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

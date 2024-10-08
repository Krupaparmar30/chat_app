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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [


                  SizedBox(height: 150),
                  Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white,fontSize: 40,letterSpacing: 1,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: controller.txtName,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,color: Colors.white,),

                          labelText: "Name",
                          labelStyle: TextStyle(
                            color: Colors.white
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
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: controller.txtEmail,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,color: Colors.white,),

                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Colors.white
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
                  SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: controller.txtPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password,color: Colors.white,),

                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: Colors.white
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
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: controller.txtConfirmPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password,color: Colors.white,),

                          labelText: "ConfirmPassword",
                          labelStyle: TextStyle(
                              color: Colors.white
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
                  SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(color: Colors.white),

                      controller: controller.txtPhone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone,color: Colors.white,),

                          labelText: "Phone",
                          labelStyle: TextStyle(
                              color: Colors.white
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
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Already have Account? Sing in",style: TextStyle(color: Colors.white),)),
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

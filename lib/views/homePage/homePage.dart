import 'dart:io';

import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
import 'package:chat_app/services/google_auth_services/google_auth_services.dart';
import 'package:chat_app/services/local_notification_services/local_notification_services.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/chat_controller/chat_controller.dart';
import '../../controllers/theme_controller/theme_controller.dart';

var chatController = Get.put(ChatController());
File? fileImage;
class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
backgroundColor: (themeControllerTrue.isDark).value
    ? Theme.of(context).colorScheme.secondary
    : Theme.of(context).colorScheme.primary,
        child: FutureBuilder(
          future: CloudFireStoreServices.cloudFireStoreServices
              .readDataFromCurrentUserFireStore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
             return CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Waiting");
            }
            Map? data = snapshot.data!.data();
            UserModalData userModalData = UserModalData.fromMap(data!);
            return Column(

                children: [
                  DrawerHeader(


                      child: CircleAvatar(
                        backgroundColor: (themeControllerTrue.isDark).value
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
                    radius: 80,
                    backgroundImage: (fileImage != null)
                        ?FileImage(fileImage!)
                        : const NetworkImage(''),

                  )),
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 20),
                       child: Row(
                         children: [ Container(
                           child: IconButton(onPressed: () async {
                             ImagePicker imagePicker = ImagePicker();
                             XFile? file = await imagePicker.pickImage(
                                 source: ImageSource.gallery);
                             fileImage = File(file!.path);

                           }, icon: Icon(Icons.photo,color: Colors.white,size: 32,)),
                         ),

                         ],
                       ),
                     ),

                     Text('Email : ${userModalData.email}',style: TextStyle(color:  (themeControllerTrue.isDark).value
                         ? Theme.of(context).colorScheme.primary
                         : Theme.of(context).colorScheme.secondary,
                     )
                       ,),
                   ],
                 ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 70),
                    child: Text('Name : ${userModalData.name}',style: TextStyle(color:  (themeControllerTrue.isDark).value
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,),),
                  ),


                  SizedBox(
                    height: 20,
                  ),

               Padding(
                 padding: const EdgeInsets.only(left: 30),
                 child: Row(
                   mainAxisSize: MainAxisSize.max,
                   children: [
                     Icon(Icons.notifications,color: (themeControllerTrue.isDark).value
                     ? Theme.of(context).colorScheme.primary
                     : Theme.of(context).colorScheme.secondary,),
                     SizedBox(
                       width: 10,
                     ),
                     Text('Notifications',style: TextStyle(color:  (themeControllerTrue.isDark).value
                         ? Theme.of(context).colorScheme.primary
                         : Theme.of(context).colorScheme.secondary,),),

                   ],
                 ),
               ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.privacy_tip_outlined,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Privacy',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.accessibility_new,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Accessibility',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.security,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Security',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.settings_suggest,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Settings',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.ads_click,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Ads',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.account_box_rounded,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Account',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.help,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Help',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.shield_moon,color: (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Theme',style: TextStyle(color:  (themeControllerTrue.isDark).value
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,),),

                        Obx(
                              () => Switch(
                            value: themeControllerTrue.isDark.value,
                            onChanged: (value) {
                              themeControllerTrue.toggleTheme();
                            },
                          ),
                        ),

                      ],
                    ),
                  ),
                ]);
          },
        ),
      ),

      appBar: AppBar(
        backgroundColor:(themeControllerTrue.isDark).value
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        title: Text(
          "Home Page",
          style: TextStyle(  color: (themeControllerTrue.isDark).value
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                 await LocalNotificationServices.notificationServices
                    .scheduledNotification();
              },
              icon: Icon(Icons.notifications,color:  (themeControllerTrue.isDark).value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,)),
          IconButton(
              onPressed: () async {
                await AuthService.authService.signOutUser();
                await GoogleAuthServices.googleAuthServices.signOutFromGoogle();

                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.login_outlined,color:  (themeControllerTrue.isDark).value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,))
        ],
      ),

      body: FutureBuilder(

        future: CloudFireStoreServices.cloudFireStoreServices
            .readAllFromCurrentFireStore(),
        builder: (context, snapshot) {
          List data = snapshot.data!.docs;
          List<UserModalData> userList = [];

          for (var user in data) {
            userList.add(UserModalData.fromMap(user.data()));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return Container(
            color:  (themeControllerTrue.isDark).value
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            child: Center(
                child: ListView.builder(

              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    chatController.getReceiver(
                        userList[index].email!, userList[index].name!);
                    Get.toNamed('/chat');
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${userList[index].image}"),
                  ),
                  title: Text('${userList[index].name}',style: TextStyle(color: (themeControllerTrue.isDark).value
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,),),
                  subtitle: Text('${userList[index].email}',style: TextStyle(
                    color: (themeControllerTrue.isDark).value
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                  ),),
                );
              },
            )),
          );
        },
      ),
    );
  }
}

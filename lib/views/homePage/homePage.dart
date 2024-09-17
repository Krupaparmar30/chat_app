import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
import 'package:chat_app/services/google_auth_services/google_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat_controller/chat_controller.dart';

var chatController = Get.put(ChatController());

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
          future: CloudFireStoreServices.cloudFireStoreServices
              .readDataFromCurrentUserFireStore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Waiting");
            }
            Map? data = snapshot.data!.data();
            UserModalData userModalData = UserModalData.fromMap(data!);
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DrawerHeader(
                      child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userModalData.image!),
                  )),
                  Text('${userModalData.email}'),
                  Text('${userModalData.name}'),
                ]);
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        title: Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.authService.signOutUser();
                await GoogleAuthServices.googleAuthServices.signOutFromGoogle();

                User? user = AuthService.authService.getCurrentUser();
                if (user == null) {
                  Get.offAndToNamed('/signIn');
                }
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      // body: FutureBuilder(
      //   future: CloudFireStoreServices.cloudFireStoreServices
      //       .readAllFromCurrentFireStore(),
      //   builder: (context, snapshot) {
      //     List data = snapshot.data!.docs;
      //     List<UserModalData> userList = [];
      //
      //     for (var user in data) {
      //       user.add(UserModalData.fromMap(user.data()));
      //     }
      //     print(userList);
      //     if (snapshot.hasError) {
      //       Text(snapshot.error.toString());
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     }
      //
      //     return ListView.builder(
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           leading: CircleAvatar(
      //             backgroundImage: NetworkImage(userList[index].image!),
      //           ),
      //           title: Text(userList[index].name!),
      //           subtitle: Text(userList[index].email!),
      //         );
      //       },
      //     );
      //   },
      // ),
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

          return Center(
              child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    chatController.getReceiver(
                        userList[index].email!, userList[index].name!);
                    Get.toNamed('/chat');
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${userList[index].image}"),
                  ),
                  title: Text('${userList[index].name}'),
                  subtitle: Text('${userList[index].email}'),
                ),
              );
            },
          ));
        },
      ),
    );
  }
}

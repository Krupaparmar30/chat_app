import 'package:chat_app/controllers/auth_controller/auth_controller.dart';
import 'package:chat_app/modal/chat_modal/chat_modal.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
import 'package:chat_app/services/local_notification_services/local_notification_services.dart';
import 'package:chat_app/services/storage_firebase_services/storage_firebase_services.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/theme_controller/theme_controller.dart';

class chatPage extends StatelessWidget {
  const chatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: (themeControllerTrue.isDark).value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
            )),
        backgroundColor: (themeControllerTrue.isDark).value
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        title: Text(
          chatController.receiverName.value,
          style: TextStyle(
            color: (themeControllerTrue.isDark).value
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: CloudFireStoreServices.cloudFireStoreServices
                .readChatFromFireStore(chatController.receiverEmail.value),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              List data = snapshot.data!.docs;
              List<ChatModal> chatList = [];
              List<String> docList = [];
              for (QueryDocumentSnapshot snap in data) {
                docList.add(snap.id);
                chatList.add(ChatModal.fromMap(snap.data() as Map));
              }

              return Container(
                // decoration: BoxDecoration(
                    color: (themeControllerTrue.isDark).value
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,


                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: List.generate(
                          chatList.length,
                          (index) => Align(
                                alignment: (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email)
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: GestureDetector(
                                  onLongPress: () {
                                    if (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Update"),
                                            content: TextField(
                                              controller:
                                                  chatController.txtUpDateMessage,
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    String dcId = docList[index];
                                                    CloudFireStoreServices
                                                        .cloudFireStoreServices
                                                        .updateChatFromFireStore(
                                                            chatController
                                                                .receiverEmail
                                                                .value,
                                                            dcId,
                                                            chatController
                                                                .txtUpDateMessage
                                                                .text);
                                                    Get.back();
                                                  },
                                                  child: Text("Update")),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  onDoubleTap: () {
                                    if (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email!) {
                                      CloudFireStoreServices
                                          .cloudFireStoreServices
                                          .removeChat(docList[index],
                                              chatController.receiverEmail.value);
                                    }
                                  },
                                  child: Container(
                  constraints:BoxConstraints(
                    maxWidth: 100,
                  ),
                  
                                    alignment: (chatList[index].sender ==
                                            AuthService.authService
                                                .getCurrentUser()!
                                                .email!)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                        color: (chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email
                                            ? Colors.blue.shade50
                                            : Colors.white),
                                        borderRadius: (chatList[index].sender ==
                                                AuthService.authService
                                                    .getCurrentUser()!
                                                    .email)
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: (chatList[index].image!.isEmpty &&
                                                chatList[index].image == "")
                                            ? Text(
                                                chatList[index].message!,
                                                style: TextStyle(
                                                    color: (chatList[index]
                                                                .sender ==
                                                            AuthService
                                                                .authService
                                                                .getCurrentUser()!
                                                                .email
                                                        ? Colors.blue.shade900
                                                        : Colors.black),
                                                    fontSize: 15),
                                              )
                                            : Image.network(
                                                chatList[index].image!,
                                                height: 100,
                                              )),
                                  ),
                                ),
                              ))),
                ),
              );
            },
          )),
          TextField(
            controller: chatController.txtMessage,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue.shade900),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue.shade900,
                    )),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () async {
                          String url = await StorageServices.storageServices
                              .uploadImages();
                          chatController.getImage(url);
                        },
                        icon: Icon(Icons.photo)),
                    IconButton(
                        onPressed: () async {
                          ChatModal chat = ChatModal(
                              image: chatController.image.value,
                              sender: AuthService.authService
                                  .getCurrentUser()!
                                  .email,
                              receiver: chatController.receiverEmail.value,
                              message: chatController.txtMessage.text,
                              time: Timestamp.now());

                          await CloudFireStoreServices.cloudFireStoreServices
                              .addChatInFireStore(chat);

                          LocalNotificationServices.notificationServices
                              .showNotificationServices(
                                  AuthService.authService
                                      .getCurrentUser()!
                                      .email!,
                                  chatController.txtMessage.text);
                        },
                        icon: Icon(Icons.send)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

// decoration: BoxDecoration(
// gradient: LinearGradient(colors: RxList([
// Color(0xff0c0f2e),
// Color(0xff292b60),
// Color(0xff344070),
// Color(0xff070b29),
//Color(0xff342463),
//Color(0xff3c4172)
//Color(0xff576aac)
//
//
//
//
// ]))
// ),

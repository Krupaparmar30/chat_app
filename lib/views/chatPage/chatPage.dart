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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: (themeControllerTrue.isDark).value
                  ? Theme
                  .of(context)
                  .colorScheme
                  .primary
                  : Theme
                  .of(context)
                  .colorScheme
                  .secondary,
            )),
        backgroundColor: (themeControllerTrue.isDark).value
            ? Theme
            .of(context)
            .colorScheme
            .secondary
            : Theme
            .of(context)
            .colorScheme
            .primary,
        title: Text(
          chatController.receiverName.value,
          style: TextStyle(
            color: (themeControllerTrue.isDark).value
                ? Theme
                .of(context)
                .colorScheme
                .primary
                : Theme
                .of(context)
                .colorScheme
                .secondary,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone,
                color: (themeControllerTrue.isDark).value
                    ? Theme
                    .of(context)
                    .colorScheme
                    .primary
                    : Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.video_call_outlined,
                color: (themeControllerTrue.isDark).value
                    ? Theme
                    .of(context)
                    .colorScheme
                    .primary
                    : Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ))
        ],
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
                        ? Theme
                        .of(context)
                        .colorScheme
                        .secondary
                        : Theme
                        .of(context)
                        .colorScheme
                        .primary,

                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: List.generate(
                              chatList.length,
                                  (index) =>
                                  Align(
                                    alignment: (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: GestureDetector(

                                      onTap: () {
                                        if (chatList[index].sender ==
                                            AuthService.authService
                                                .getCurrentUser()!.email) {
                                          chatController.txtUpDateMessage =
                                              TextEditingController(
                                                  text: chatList[index]
                                                      .message);
                                          print("dftgyhu");
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Update"),
                                                content: TextField(
                                                  controller: chatController
                                                      .txtUpDateMessage,
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
                                                    child: Text("Update"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      onDoubleTap: () {
                                        CloudFireStoreServices
                                            .cloudFireStoreServices.removeChat(
                                            chatController.receiverEmail.value,
                                            docList[index]);
                                      },
                                      child: Container(

                                        width: 200,
                                          alignment: (chatList[index].sender ==
                                              AuthService.authService
                                                  .getCurrentUser()!
                                                  .email!)
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 2,
                                            vertical: 1,
                                          ),

                                          decoration: BoxDecoration(
                                              color: (chatList[index].sender ==
                                                  AuthService.authService
                                                      .getCurrentUser()!
                                                      .email!
                                                  ? Colors.blue.shade50
                                                  : Colors.white),
                                              borderRadius: (chatList[index]
                                                  .sender ==
                                                  AuthService.authService
                                                      .getCurrentUser()!
                                                      .email!)
                                                  ? const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomLeft:
                                                  Radius.circular(10))
                                                  : const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10))),

                                          child: (chatList[index].image!
                                              .isEmpty &&
                                              chatList[index].image == "")
                                              ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, top: 5, right: 10, bottom: 5),
                                              child: Text.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                      chatList[index].message!,
                                                      style: TextStyle(
                                                          color: (chatList[index]
                                                              .sender ==
                                                              AuthService
                                                                  .authService
                                                                  .getCurrentUser()!
                                                                  .email
                                                              ? Colors.blue
                                                              .shade900
                                                              : Colors.black),
                                                          fontSize: 15),
                                                    ),
                                                    TextSpan(
                                                        text:
                                                        "\t\t${(chatList[index]
                                                            .time!.toDate()
                                                            .hour > 9 &&
                                                            chatList[index]
                                                                .time!.toDate()
                                                                .hour < 24)
                                                            ? (chatList[index]
                                                            .time!.toDate()
                                                            .hour % 12)
                                                            : '0${(chatList[index]
                                                            .time!.toDate()
                                                            .hour)}'} : ${(chatList[index]
                                                            .time!.toDate()
                                                            .minute > 9)
                                                            ? (chatList[index]
                                                            .time!.toDate()
                                                            .minute)
                                                            : '0${(chatList[index]
                                                            .time!.toDate()
                                                            .minute)}'} ",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors
                                                                .blue
                                                                .shade900)),
                                                    TextSpan(
                                                        text: (chatList[index]
                                                            .time!
                                                            .toDate()
                                                            .hour >
                                                            12)
                                                            ? 'PM'
                                                            : 'AM',
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors
                                                                .blue
                                                                .shade900)),
                                                  ])))
                                              : Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child:Container(

                                                  height: height * 0.3,
                                                  width: width * 0.4,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage(

                                                      chatList[index].image!,



                                                    ),)
                                                  ),
                                                )
                                              )),
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

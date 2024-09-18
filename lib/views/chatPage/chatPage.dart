import 'package:chat_app/controllers/auth_controller/auth_controller.dart';
import 'package:chat_app/modal/chat_modal/chat_modal.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class chatPage extends StatelessWidget {
  const chatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatController.receiverName.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                List<String> docList=[];
                for (QueryDocumentSnapshot snap in data) {
                  docList.add(snap.id);
                  chatList.add(ChatModal.fromMap(snap.data() as Map));
                }

                return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                        chatList.length,
                        (index) => GestureDetector(
                              onLongPress: () {
                                if(chatList[index].sender==AuthService.authService.getCurrentUser()!.email)
                                  {
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


                                                  String dcId=docList[index];
                                                  CloudFireStoreServices.cloudFireStoreServices.updateChatFromFireStore(chatController.receiverEmail.value, dcId, chatController.txtUpDateMessage.text);
                                                  Get.back();
                                                },
                                                child: Text("Update")),
                                          ],
                                        );
                                      },
                                    );
                                  }

                              },
                              child: Container(
                                alignment: (chatList[index].sender ==
                                        AuthService.authService
                                            .getCurrentUser()!
                                            .email!)
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(chatList[index].message!),
                                ),
                              ),
                            )));
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
                  suffixIcon: IconButton(
                      onPressed: () async {
                        ChatModal chat = ChatModal(
                            sender:
                                AuthService.authService.getCurrentUser()!.email,
                            receiver: chatController.receiverEmail.value,
                            message: chatController.txtMessage.text,
                            time: Timestamp.now());

                        await CloudFireStoreServices.cloudFireStoreServices
                            .addChatInFireStore(chat);
                      },
                      icon: Icon(Icons.send))),
            )
          ],
        ),
      ),
    );
  }
}

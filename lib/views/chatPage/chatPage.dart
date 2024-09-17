import 'package:chat_app/modal/chat_modal/chat_modal.dart';
import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                for (QueryDocumentSnapshot snap in data) {
                  chatList.add(ChatModal.fromMap(snap.data() as Map));
                }

                return ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) =>
                      Text(chatList[index].message!),
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

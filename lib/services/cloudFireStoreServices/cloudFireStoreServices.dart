import 'package:chat_app/modal/chat_modal/chat_modal.dart';
import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth_services/auth_services.dart';

class CloudFireStoreServices {
  CloudFireStoreServices._();

  static CloudFireStoreServices cloudFireStoreServices =
      CloudFireStoreServices._();

  FirebaseFirestore fireBaseFireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModalData user) {
    fireBaseFireStore.collection("users").doc(user.email).set({
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'token': user.token
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>
      readDataFromCurrentUserFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireBaseFireStore.collection("users").doc(user!.email).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      readAllFromCurrentFireStore() async {
    User? user = AuthService.authService.getCurrentUser();
    return await fireBaseFireStore.collection("users").where("email",isNotEqualTo: user!.email).get();
  }

  Future<void> addChatInFireStore(ChatModal chat) async {
    String? sender = chat.sender;
    String? receiver = chat.receiver;
    List doc = [sender, receiver];

    doc.sort();
    String docId = doc.join("_");

    await fireBaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .add(chat.getMap(chat));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readChatFromFireStore(
      String receiver) {
    String? sender = AuthService.authService.getCurrentUser()!.email;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    return fireBaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .orderBy("time", descending: false)
        .snapshots();
  }

  Future<void> updateChatFromFireStore(String receiver, String dcId, String message) async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

 await   fireBaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId)
        .update({'message': message});
  }


  Future<void> removeChat(String receiver, String dcId)
  async {
    String sender = AuthService.authService.getCurrentUser()!.email!;
    List doc = [sender, receiver];
    doc.sort();
    String docId = doc.join("_");

    await fireBaseFireStore
        .collection("chatroom")
        .doc(docId)
        .collection("chat")
        .doc(dcId).delete();

  }

}

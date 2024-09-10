import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreServices {
  CloudFireStoreServices._();

  static CloudFireStoreServices cloudFireStoreServices =
      CloudFireStoreServices._();

  FirebaseFirestore fireBaseFireStore = FirebaseFirestore.instance;

  void insertUserIntoFireStore(UserModalData user) {
    fireBaseFireStore.collection("users").doc(user.email).set({
      'name': user.name,
      'email': user.email,
      'image':user.image,
      'password': user.password,
      'phone': user.phone,
      'token': user.token
    });
  }
}

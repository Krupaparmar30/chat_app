import 'dart:developer';

import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:chat_app/services/cloudFireStoreServices/cloudFireStoreServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  GoogleAuthServices._();

  static GoogleAuthServices googleAuthServices = GoogleAuthServices._();

  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(authCredential);
      UserModalData user = UserModalData(
          name: userCredential.user!.displayName.toString(),
          email: userCredential.user!.email.toString(),
          image: userCredential.user!.photoURL.toString(),
          phone: userCredential.user!.phoneNumber.toString(),
          token: '------');

CloudFireStoreServices.cloudFireStoreServices.insertUserIntoFireStore(user);
      log(userCredential.user!.email!);
      log(userCredential.user!.photoURL!);
    }
    catch (e) {
      Get.snackbar("Google sign in failed!!!", e.toString());
      log(e.toString());
    }
  }


  Future<void> signOutFromGoogle() async {
    await googleSignIn.signOut();
  }
}

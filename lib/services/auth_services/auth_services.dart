import 'dart:developer';

import 'package:chat_app/modal/cloud_modal/cloud_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  AuthService._();

  static AuthService authService = AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Account Create - Sign Up
  Future<void> createAccountWithEmailAndPassword(
      String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Account Login - Sign In
  signInWithEmailAndPassword(String email, String password)  async {
    try
        {
          await  _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password);
          return "success";
        }
        catch(e)
    {
      return e.toString();
    }
  }

  //Account Sign Out

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

  //get current user

  User? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      log("email:${user.email}");
    }
    return user;
  }




}

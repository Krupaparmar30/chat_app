import 'package:chat_app/services/auth_services/auth_services.dart';
import 'package:chat_app/views/auth/sign_in/sign_in.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:flutter/material.dart';

class authManger extends StatelessWidget {
  const authManger({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser() == null)
        ? signIn()
        : homePage();
  }
}

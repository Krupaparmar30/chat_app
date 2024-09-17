import 'package:chat_app/views/auth/auth_manger/auth_manger.dart';
import 'package:chat_app/views/auth/sign_in/sign_in.dart';
import 'package:chat_app/views/auth/sign_up/sign_up.dart';
import 'package:chat_app/views/chatPage/chatPage.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => authManger(),),
        GetPage(name: '/signIn', page: () => signIn(),),
        GetPage(name: '/signUp', page: () => signUp(),),
        GetPage(name: '/home', page: () => homePage(),),
        GetPage(name: '/chat', page: () => chatPage(),)
      ],
    );
  }
}

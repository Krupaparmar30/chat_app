import 'package:chat_app/services/firebase_messaging_services/firebase_messaging_services.dart';
import 'package:chat_app/services/local_notification_services/local_notification_services.dart';
import 'package:chat_app/views/auth/auth_manger/auth_manger.dart';
import 'package:chat_app/views/auth/sign_in/sign_in.dart';
import 'package:chat_app/views/auth/sign_up/sign_up.dart';
import 'package:chat_app/views/chatPage/chatPage.dart';
import 'package:chat_app/views/homePage/homePage.dart';
import 'package:chat_app/views/splesh_page/splesh_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  await FirebaseMessagingServices.firebaseMessagingServices.requestPermission();
  await FirebaseMessagingServices.firebaseMessagingServices.getDeviceToken();

  await LocalNotificationServices.notificationServices
      .initNotificationServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0xff0c0f2e),
            secondary: Colors.white,

          )
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(
              primary: Colors.white,
              secondary: Color(0xff0c0f2e),

          )
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => const spleshScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: '/authmanager',
          page: () => authManger(),
        ),
        GetPage(
          name: '/signIn',
          page: () => signIn(),
        ),
        GetPage(
          name: '/signUp',
          page: () => signUp(),
        ),
        GetPage(
          name: '/home',
          page: () => homePage(),
        ),
        GetPage(
          name: '/chat',
          page: () => chatPage(),
        ),
      ],
    );
  }
}

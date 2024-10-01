import 'package:chat_app/controllers/themedata/themedata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/homePage/homePage.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
  }



  ThemeData get currentTheme
  {
    return isDark.value? ThemeData.dark():ThemeData.dark();
  }
}
 var themeControllerTrue = Get.put(ThemeController());
//
// bool themeIsDark = false;
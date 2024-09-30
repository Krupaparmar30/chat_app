import 'package:get/get.dart';

import '../../views/homePage/homePage.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
  }
}

var themeControllerTrue = Get.put(ThemeController());

bool themeIsDark = false;

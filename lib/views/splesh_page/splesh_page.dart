import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class spleshScreen extends StatelessWidget {
  const spleshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Get.offAllNamed('/authmanager');
      },
      child: Container(
        height: 700,
        width: 500,
        // decoration: BoxDecoration(
        //
        //   image: DecorationImage(
        //
        //       fit: BoxFit.cover,
        //
        //       image: AssetImage('assets/images/sp2.png'))
        // ),

        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: RxList([
          Color(0xff0c0f2e),
          Color(0xff292b60),
        ]))),
        child: const Center(
            child: Text(
          "CHAT APP",
          style: TextStyle(color: Colors.white, fontSize: 32, letterSpacing: 3),
        )),
      ),
    );
  }
}

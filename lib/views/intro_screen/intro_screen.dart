import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class introScreen extends StatelessWidget {
  const introScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              "WELCOME TO",
              style: TextStyle(
                  color: Colors.blue.shade900, letterSpacing: 2, fontSize: 32),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "CHAT",
              style: TextStyle(
                  color: Colors.blue.shade900, letterSpacing: 2, fontSize: 32),
            ),
            Text(
              "Get Started",
              style: TextStyle(
                  color: Colors.blue.shade900, letterSpacing: 2, fontSize: 32),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(

                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage("assets/images/in.png"))),
            ),
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              onDoubleTap: () {
                Get.offAndToNamed('/authmanager');

              },

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: RxList([
                    Color(0xff0c0f2e),
                    Color(0xff292b60),
                  ]))),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, letterSpacing: 2),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

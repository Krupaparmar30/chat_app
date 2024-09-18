

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController
{
  RxString receiverEmail="".obs;
  RxString receiverName="".obs;


  TextEditingController txtMessage=TextEditingController();
  TextEditingController txtUpDateMessage=TextEditingController();
  void getReceiver(String email,String name)
  {
    receiverName.value=name;
    receiverEmail.value=email;
  }
}
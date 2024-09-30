import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageServices {
  StorageServices._();

  static StorageServices storageServices = StorageServices._();

  FirebaseStorage firebaseFireStore = FirebaseStorage.instance;

  Future<String> uploadImages() async {
    XFile? images=await ImagePicker ().pickImage(source: ImageSource.gallery);

   final reference= firebaseFireStore.ref();
   final imageReference=reference.child("images/${images!.name}");
  await imageReference.putFile(File(images.path));

  String url=await imageReference.getDownloadURL();
  return url;

  }
}

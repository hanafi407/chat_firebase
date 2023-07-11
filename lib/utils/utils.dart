import 'dart:ffi';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<Uint8List> pickImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();

    XFile? pickImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    Uint8List bytes;
    bytes = await pickImage!.readAsBytes();

    return bytes;
  }

  static Future<Uint8List> nullImage() async {
    ByteData bytes = await rootBundle.load('assets/images/default_images.jpg');
    Uint8List imageNull = bytes.buffer.asUint8List();

    return imageNull;
  }

  static Future<String> uploadStorage(Uint8List file, String child1) async {
    FirebaseStorage _firebaseStorega = FirebaseStorage.instance;

    Reference ref = _firebaseStorega.ref(child1).child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String userPhotoUrl = await snap.ref.getDownloadURL();

    return userPhotoUrl;
  }
}

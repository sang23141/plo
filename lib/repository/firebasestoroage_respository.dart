import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadProfileImageToStorage(
      String childName, File file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>?> uploadPostImageToStorage(
      List<Object> files, String pid) async {
    List<String> downloadUrls = [];
    try {
      for (int i = 0; i < files.length; i++) {
        if (files[i] is String) {
          downloadUrls.add(files[i] as String);
        } else if (files[i] is File) {
          File file = files[i] as File;

          Reference ref =
              _storage.ref().child(pid).child(_auth.currentUser!.uid);

          UploadTask uploadTask = ref.putFile(file);

          TaskSnapshot snap = await uploadTask;

          String downloadUrl = await snap.ref.getDownloadURL();

          downloadUrls.add(downloadUrl);
        }
      }
      return downloadUrls;
    } catch (error) {
      // Handle or log the error
      return null;
    }
  }
}
final firebaseStorageProvider = Provider<StorageMethods>((ref) {
  return StorageMethods();
});

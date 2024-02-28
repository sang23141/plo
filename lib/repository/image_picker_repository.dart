import 'dart:io';
import 'dart:typed_data';
import 'package:email_vertify/common/utils/log_util.dart';
import 'package:email_vertify/model/types/return_type.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//  File? _pickedImageFile;
//  class ImagePickerRepository {
//   Future<File?>  pickImageFromGallery() async {

//       final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
//       if (pickedImage ==null) {
//         return null ;
//       }
//       _pickedImageFile = File(pickedImage.path);
//       return _pickedImageFile;
//   }

//   Future<File?> pickImageFromCamera() async {

//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
//     if (pickedImage == null) {
//       return null ;
//     }
//     _pickedImageFile = File(pickedImage.path);
//     return _pickedImageFile;
//   }
//  }
// for picking up image from camera
class ImagePickerRepository {
  Future pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        final FileCompression = [File(file!.path)];
        await compressImage(FileCompression);
        return SuccessReturnType(isSuccess: true, data: FileCompression[0]);
      }
      return SuccessReturnType(isSuccess: true, data: null);
    } on PlatformException catch (error) {
      return ErrorReturnType(message: "갤러리 접근을 허용해주세요", error: error);
    } catch (error) {
      return ErrorReturnType(error: error);
    }
  }

// for picking up image from gallery
  Future pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

      if (file != null) {
        return SuccessReturnType(isSuccess: true, data: File(file.path));
      } else {
        return SuccessReturnType(isSuccess: false);
      }
    } on PlatformException catch (error) {
      return ErrorReturnType(message: "카메라 접근을 허용해주세요", error: error);
    } catch (error) {
      return ErrorReturnType(error: error);
    }
  }

  Future<bool> compressImage(List<File> files) async {
    try {
      int imgCount = files.length;
      int imgCompressed = 0;
      for (int i = 0; i < files.length; i++) {
        Uint8List? image_as_bytes = await FlutterImageCompress.compressWithFile(
            files[i].path,
            quality: 50);
        if (image_as_bytes != null) {
          imgCompressed++;
          File compressedFile =
              await File(files[i].path).writeAsBytes(image_as_bytes);
          files[i] = compressedFile;
        }
      }
      logToConsole("$imgCompressed/$imgCount images compressed");
      return true;
    } catch (error) {
      logToConsole("compressedImages() error: ${error.toString()}");
      return false;
    }
  }
}

final imagePickerRepositoryProvider =
    Provider<ImagePickerRepository>((ref) => ImagePickerRepository());

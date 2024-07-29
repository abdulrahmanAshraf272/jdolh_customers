// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

const int MB = 1048576;
Future<XFile?> pickImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  XFile? xFile;
  File myFile;
  int fileSize;

  try {
    xFile = await _picker.pickImage(source: ImageSource.gallery);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }

  if (xFile == null) {
    // User canceled image picking
    return null;
  }

  try {
    myFile = File(xFile.path);
    fileSize = await myFile.length();

    // Validate the file extension
    String extension = getExtension(xFile.path);

    if (isValidImageExtension(extension)) {
      // Handle the valid image
      return xFile;
    } else if (fileSize > MB * 5) {
      Get.rawSnackbar(message: 'حجم الصورة لا يجب ان يتعدى ال5 ميجا');
      return null;
    } else {
      // Handle invalid image extension (e.g., it's not a common image file)
      Get.rawSnackbar(
          message: 'صورة الملف غير مسموح بيها, تأكد انك قمت برفع صورة');
      return null;
    }
  } catch (e) {
    print("Error processing image file: $e");
    Get.rawSnackbar(message: 'Error processing image file: $e');
    return null;
  }
}

String getExtension(String path) {
  return path.split('.').last;
}

bool isValidImageExtension(String extension) {
  return ['jpg', 'jpeg', 'png', 'gif'].contains(extension.toLowerCase());
}

// Future pickImageFromGallery() async {
//   final ImagePicker _picker = ImagePicker();
//   XFile? xfile;
//   File myFile;
//   var fileSize;

//   try {
//     xfile = await _picker.pickImage(source: ImageSource.gallery);
//   } catch (e) {
//     print("Error picking image: $e");
//     return;
//   }
//   if (xfile == null) {
//     // User canceled image picking
//     return null;
//   }

//   myFile = File(xfile.path);

//   //Get file size
//   fileSize = await myFile.length();
//   // Validate the file extension
//   String extension = getExtension(xfile.path);

//   if (isValidImageExtension(extension)) {
//     // Handle the valid image
//     return xfile;
//   } else if (fileSize > MB * 5) {
//     Get.rawSnackbar(message: 'حجم الصورة لا يجب ان يتعدى ال5 ميجا');
//     return null;
//   } else {
//     // Handle invalid image extension (e.g., it's not a common image file)
//     Get.rawSnackbar(
//         message: 'صورة الملف غير مسموح بيها, تأكد انك قمت برفع صورة');
//     return null;
//   }
// }

// bool isValidImageExtension(String extension) {
//   // List of common image extensions
//   List<String> validExtensions = ['jpg', 'jpeg', 'png'];

//   // Check if the extension is in the valid extensions list
//   return validExtensions.contains(extension.toLowerCase());
// }

// String getExtension(String filename) {
//   // Split the filename based on "."
//   List<String> parts = filename.split('.');

//   // Check if there's at least one dot (meaning there might be an extension)
//   if (parts.length > 1) {
//     // Return the last part, which is the extension
//     return parts.last;
//   } else {
//     // No extension found, return an empty string
//     return '';
//   }
// }

Future<void> pickImageFromCamera() async {
  final ImagePicker _picker = ImagePicker();
  XFile? xfile;

  try {
    xfile = await _picker.pickImage(source: ImageSource.camera);
  } catch (e) {
    print("Error picking image: $e");
    return;
  }

  if (xfile == null) {
    // User canceled image picking
    return;
  }

  // Validate the file extension
  String extension = getExtension(xfile.path);

  if (isValidImageExtension(extension)) {
    // Handle the valid image
    print("Selected image path: ${xfile.path}");
  } else {
    // Handle invalid image extension (e.g., it's not a common image file)
    print("Invalid image extension: $extension");
  }
}

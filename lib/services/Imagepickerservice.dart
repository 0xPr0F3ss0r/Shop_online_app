import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery or camera
  Future<File?> pickImage(ImageSource source) async {
    try {
      // Pick an image
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        return File(image.path); // Return the File object of the image
      } else {;
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

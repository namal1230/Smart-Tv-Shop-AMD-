import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> selectImage(String option) async {
    try {
     final XFile? pickedFile = await _picker.pickImage(source: option == "gallery" ? ImageSource.gallery : ImageSource.camera);

     if (pickedFile == null) return null;

     return File(pickedFile.path);
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }
}

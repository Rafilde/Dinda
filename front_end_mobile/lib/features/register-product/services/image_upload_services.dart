import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {

  Future<List<XFile>> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage();
    return pickedFile;
  }


}
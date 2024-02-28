import 'package:image_picker/image_picker.dart';

// ignore: non_constant_identifier_names
PickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? image = await imagePicker.pickImage(source: source);

  if (image != null) {
    return await image.readAsBytes();
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify/models/user.dart';
import 'package:taskify/utils/imagepicker.dart';
import 'package:taskify/utils/shared.dart';

class PhotoProfile extends StatefulWidget {
  const PhotoProfile({
    super.key,
  });

  @override
  State<PhotoProfile> createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<PhotoProfile> {
  void selectImage() async {
    Uint8List? image = await PickImage(ImageSource.gallery);

    if (user == null && image != null) {
      user = User(name: "", major: "Ilmu Komputer", dateBirth: "", email: "");
      setState(() {
        user!.image = image;
      });
    } else {
      if (image != null) {
        setState(() {
          user!.image = image;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          if (user != null && user!.image != null)
            CircleAvatar(
              radius: 50,
              backgroundImage: MemoryImage(user!.image!),
            )
          else
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/logo.png"),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: backgroundColour,
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColour,
                  width: 2,
                ),
              ),
              child: GestureDetector(
                onTap: selectImage,
                child: Icon(
                  Icons.edit,
                  color: primaryColour,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

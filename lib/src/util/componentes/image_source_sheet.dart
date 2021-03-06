import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/util/upload/upload_response.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;
  UploadFileResponse uploadFileResponse;
  UploadRespnse uploadRespnse;

  File file;
  PickedFile pickedFile;
  var picker = ImagePicker();

  ImageSourceSheet({this.onImageSelected});

  imageSelected(File image) async {
    if (image != null) {
      File croppedImage = await ImageCropper.cropImage(sourcePath: image.path);
      onImageSelected(croppedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera_alt_outlined),
            title: Text("Camera"),
            onTap: () async {
              pickedFile = await picker.getImage(source: ImageSource.camera);
              file = File(pickedFile.path);
              print("File: ${file}");
              imageSelected(file);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Galeria"),
            onTap: () async {
              pickedFile = await picker.getImage(source: ImageSource.gallery);
              file = File(pickedFile.path);
              print("File: ${file}");
              // imageSelected(file);
            },
          ),
        ],
      ),
    );
  }
}

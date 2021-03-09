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
              File image =
                  await ImagePicker.pickImage(source: ImageSource.camera);
              imageSelected(image);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Galeria"),
            onTap: () async {
              File image =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              imageSelected(image);
            },
          ),
        ],
      ),
    );
  }
}

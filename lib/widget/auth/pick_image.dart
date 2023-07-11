import 'dart:typed_data';

import 'package:chat_firebase/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  PickImage(this.fileFoto);

  final void Function(Uint8List file) fileFoto;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  Uint8List? _pickedImage;
  bool isIcon = true;

  _pickImage() async {
    Uint8List pickedImage = await Utils.pickImage(
      ImageSource.gallery,
    );

    setState(() {
      _pickedImage = pickedImage;
      isIcon = false;
    });

    widget.fileFoto(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Utils.nullImage(),
        builder: (context, snape) {
          if (snape.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_pickedImage == null) {
            _pickedImage = snape.data!;
            widget.fileFoto(_pickedImage!);
          }

          return snape.hasData
              ? Stack(
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: _pickedImage == null
                            ? MemoryImage(snape.data!)
                            : MemoryImage(_pickedImage!),
                      ),
                    ),
                    Positioned(
                        bottom: -10,
                        right: -10,
                        child: IconButton(
                          icon: isIcon ? Icon(Icons.add_a_photo) : Text(''),
                          onPressed: _pickImage,
                        ))
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}

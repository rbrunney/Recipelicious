import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class UploadImageIcons extends StatefulWidget {
  String imgUrl;
  bool hasImg;
  UploadImageIcons({Key? key, this.hasImg = false, this.imgUrl = ''}) : super(key: key);

  @override
  State<UploadImageIcons> createState() => _UploadImageIconsState();
}

class _UploadImageIconsState extends State<UploadImageIcons> {
  final ImagePicker imagePicker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    pickImage(ImageSource typeOfPhoto) async {
      XFile? xFileImage = await imagePicker.pickImage(source: typeOfPhoto);
      if (xFileImage != null) {
        image = File(xFileImage.path);
        setState(() {});
      }
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 90, 90, 90),
                        shape: BoxShape.rectangle),
                    child: IconButton(
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      iconSize: 20,
                      onPressed: () async {
                        await pickImage(ImageSource.gallery);
                      },
                    )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 90, 90, 90),
                        shape: BoxShape.rectangle),
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo_outlined),
                      iconSize: 20,
                      onPressed: () async {
                        await pickImage(ImageSource.camera);
                      },
                    )),
              ),
            ],
          ),
        ),
        if (image != null)
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.file(
                image!,
                width: 350,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          )
        else if(widget.hasImg)
        Card(
            margin: const EdgeInsets.all(10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.network(
                widget.imgUrl,
                width: 350,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          )
      ],
    );
  }
}

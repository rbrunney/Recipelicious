import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../util/globals.dart' as globals;
import '../../../util/requests.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class UploadImageIcons extends StatefulWidget {
  String imgUrl;
  bool hasImg;
  UploadImageIcons({Key? key, this.hasImg = false, this.imgUrl = ''})
      : super(key: key);

  @override
  State<UploadImageIcons> createState() => _UploadImageIconsState();
}

class _UploadImageIconsState extends State<UploadImageIcons> {
  final ImagePicker imagePicker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    uploadImage() {
      Requests()
          .makeGetRequest(
              "http://10.0.2.2:8888/generateLink/put/${globals.imgUrl.split('/').last}")
          .then((value) async {
        File file = File(globals.imgUrl);
        final stream = http.ByteStream(Stream.castFrom(file.openRead()));
        final length = await file.length();

        var request = http.MultipartRequest(
            'PUT', Uri.parse(json.decode(value)["results"]));

        request.files.add(await http.MultipartFile.fromPath(
            'file', globals.imgUrl,
            contentType: MediaType('image', 'jpeg')));
        request.fields.addAll(
            {'key': globals.imgUrl.split('/').last, 'acl': 'public-read'});

        await request.send();
        globals.imgUrl =
            "https://whatsfordinner-pro290.s3.us-west-1.amazonaws.com/${globals.imgUrl.split('/').last}";
      });
    }

    pickImage(ImageSource typeOfPhoto) async {
      XFile? xFileImage = await imagePicker.pickImage(source: typeOfPhoto);
      if (xFileImage != null) {
        image = File(xFileImage.path);
        globals.imgUrl = image!.path;
        uploadImage();
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
        else if (widget.hasImg)
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

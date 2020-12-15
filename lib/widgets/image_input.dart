import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    PickedFile imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    final imageData = new File('assets/images/salad.jpg');
    uploadImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text(
            '請加入照片',
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('拍攝餐點'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
  uploadImage(File img) async {
    FormData formData = FormData.fromMap({
      "Content-Type": "image/jpeg", //这里写其他需要传递的参数
      "file": await MultipartFile.fromFile(img.path, filename:'salad.jpg'),
    });
    var response =
    await Dio().post("https://api-2445582032290.production.gw.apicast.io/v1/foodrecognition?user_key=c4426b33b1d760226237ac8550ac193e", data: formData);
    print(response);
    if (response.statusCode == 200) {
      Map responseMap = response.data;
      print(responseMap);
    }
    else{
      var code=response.statusCode;
      print("Error: $code");
    }
  }
}

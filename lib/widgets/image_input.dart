
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import '../screens/places_list_screen.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 544,
      maxHeight: 544,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    print(savedImage);
    uploadImage(savedImage);
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.redAccent),
          ),
          child: _storedImage != null
              ? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text(
            '你還沒拍照喔',
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
            label: Text('為你的食物拍一張吧'),
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
      "file": await MultipartFile.fromFile(img.path, filename: 'salad.jpg'),
    });
    var response =
    await Dio().post(
        "https://api-2445582032290.production.gw.apicast.io/v1/foodrecognition?user_key=c4426b33b1d760226237ac8550ac193e",
        data: formData);
    print(response);
    if (response.statusCode == 200) {
      Map responseMap = response.data;
      //print(responseMap);
      print('');
      print('${responseMap['is_food']}');
      print('${responseMap['_timing']['foodai_totaltime']}');
      print(' ');
      final String ProductName = responseMap['results'][0]['items'][1]['name'];
      //    final double Calories = responseMap['results'][0]['items'][1]['nutrition']['calories'];
      final int calories = responseMap['results'][0]['items'][1]['nutrition']['calories'];
      final double totalCarbs = responseMap['results'][0]['items'][1]['nutrition']['totalCarbs'];
      final double totalFat = responseMap['results'][0]['items'][1]['nutrition']['totalFat'];
      final double protein = responseMap['results'][0]['items'][1]['nutrition']['protein'];

      print(ProductName);
      print(totalCarbs);
      print(totalFat);
      print(protein);
      print(calories);
      showDialog(
        context: context,
        builder: (ctx) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('辨識結果: ' + ProductName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Text('碳水: '+totalCarbs.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Text('脂肪: '+ totalFat.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Text('蛋白質: ' + protein.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                Text('熱量: ' + calories.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
              ],
            ),
          );
        },
      );
    }
    else {
      var code = response.statusCode;
      print("Error: $code");
    }
  }
}

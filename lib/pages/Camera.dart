import 'package:flutter/material.dart';

import '../widgets/image_input.dart';
import '../main2.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('紀錄今日餐點'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: '餐點名稱'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 40,),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 100, // specific value
            height: 80,
          child:RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('加入食物日記',),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp()));

            },
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Colors.pink,
          ),
          ),
        ],
      ),
    );
  }
}


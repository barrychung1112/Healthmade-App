import 'package:flutter/material.dart';
import 'package:healthmade/pages/Camera.dart';
import 'login2.dart';
import '../screens/categories_screen.dart';
import '../main2.dart';
import 'package:curl/curl.dart';
import 'package:http/http.dart';

class Compute extends StatelessWidget {
  final String name;
  final String weight;
  final String height;
  final String age;
  Compute(this.name, this.weight,this.height,this.age);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('計算頁面'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "計算頁",
                  hintText: "請輸入您的學號 ...",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "計算頁",
                  hintText: "輸入您的Portal密碼 ...",
                ),
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPlaceScreen()));},
    ),
    ),
    ],
    ),
    ),
    );
  }
}
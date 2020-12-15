import 'package:flutter/material.dart';
import 'compute.dart';
import '../screens/categories_screen.dart';

class LoginPage2 extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  final TextEditingController _controllerr = new TextEditingController();
  final TextEditingController _controllerrr = new TextEditingController();
  final TextEditingController _controllerrrr = new TextEditingController();
  final TextEditingController _controllersex = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("輸入身體資料"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              height: 180,
              child: Center(
                child: Image.asset("assets/images/12.png"),),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: "姓名",
                ),
                controller: _controllerrrr,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.emoji_people),
                  labelText: "身高",
                ),
                controller: _controller,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "體重",
                  hintText: "女人的秘密...",
                ),
                controller: _controllerr,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  //suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "年齡",
                  hintText: "請輸入真實年齡",
                ),
                controller: _controllerrr,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  //suffixIcon: Icon(Icons.remove_red_eye),
                  labelText: "性別",
                  hintText: "請輸入性別",
                ),
                controller: _controllersex,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              height: 48.0,
              child: RaisedButton(
                child: Text("計算一日所需",style: TextStyle(fontSize: 25,color: Colors.blue),),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Compute(_controllerrrr.text, int.parse(_controller.text), int.parse(_controllerr.text), int.parse(_controllerrr.text))));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
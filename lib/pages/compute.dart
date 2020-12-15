import 'package:flutter/material.dart';
import 'package:healthmade/pages/Camera.dart';
import 'login2.dart';
import '../screens/categories_screen.dart';
import '../main2.dart';
import 'package:curl/curl.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Compute extends StatelessWidget {
  final String name;
  final int weight;
  final int height;
  final int age;
  Compute(this.name, this.height,this.weight,this.age);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "蛋白質": double.parse('${weight*0.35}'),
      "脂肪": double.parse('${weight*0.16}'),
      "碳水化合物": double.parse('${weight*0.48}'),
    };
    double new_high=height*0.01;
    double count=new_high*new_high;
    var bmi=weight/count;
    var bmr=13.397*weight+4.799*height-5.677*age+88.362;
    return Scaffold(
      appBar: AppBar(
        title: Text('$name 這是你的每日營養參考'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 400,
              height: 100,
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffFFE6D9), Color(0xffFFAD86)],
                ),
                border: Border.all(
                    color: Color(0xff0D47A1)
                ),
              ),
              child:
              Text('每日應攝取熱量(Kcal)BMR: $bmr',style: TextStyle(fontSize:20)),
            ),
            Container(
              alignment: Alignment.center,
              width: 400,
              height: 80,
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffF1E1FF), Color(0xffCA8EFF), Colors.deepPurpleAccent],
                ),
                border: Border.all(
                    color: Color(0xff0D47A1)
                ),
              ),
              child:
              Text('目前 BMI: $bmi',style: TextStyle(fontSize:20)),
            ),

            Container(
                child: PieChart(dataMap: dataMap),
            ),
            Container(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              new CircularPercentIndicator(
              radius: 70.0, //大小
                lineWidth: 5.0,//指示線條大小
                percent: 0.6,//當前進度
                center: new Text("本日熱量"),//中心widget 可以是文字 或其他widget 如何icon
                progressColor: Colors.deepOrange, //進度條顏色
              ),
                  new CircularPercentIndicator(
                    radius: 70.0, //大小
                    lineWidth: 5.0,//指示線條大小
                    percent: 0.8,//當前進度
                    center: new Text("蛋白質"),//中心widget 可以是文字 或其他widget 如何icon
                    progressColor: Colors.deepOrange, //進度條顏色
                  ),
                  new CircularPercentIndicator(
                    radius: 70.0, //大小
                    lineWidth: 5.0,//指示線條大小
                    percent: 0.4,//當前進度
                    center: new Text("碳水"),//中心widget 可以是文字 或其他widget 如何icon
                    progressColor: Colors.deepOrange, //進度條顏色
                  )],
              )
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
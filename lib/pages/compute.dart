import 'package:flutter/material.dart';
import 'package:healthmade/pages/Camera.dart';
import 'login2.dart';
import '../screens/categories_screen.dart';
import '../main2.dart';
import 'package:curl/curl.dart';
import 'package:http/http.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Cameramain.dart';
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
    var bmi=(weight/count).toStringAsFixed(2);
    var bmr=(13.397*weight+4.799*height-5.677*age+88.362).toStringAsFixed(2);
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
                  color: Color(0xffFFAD86)
                  ,
                  border: Border.all(
                      color: Colors.white
                  ),
                ),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('目前 BMI: ',style: TextStyle(fontSize:20)),
                      Text('${double.parse(bmi)}',style: TextStyle(fontSize:25))
                    ]
                )

            ),
            if(double.parse(bmi)>24)
              Text('BMI過重: ${(double.parse(bmi)-24).toStringAsFixed(2)}',style: TextStyle(fontSize:15, color: Colors.red)),
            if(double.parse(bmi)<18)
              Text('BMI過輕: ${(18-double.parse(bmi)).toStringAsFixed(2)}',style: TextStyle(fontSize:15, color: Colors.blue)),
            Container(
              alignment: Alignment.center,
              width: 400,
              height: 80,
              decoration: new BoxDecoration(
                color:  Color(0xffCA8EFF)
                ,
                border: Border.all(
                    color: Color(0xff0D47A1)
                ),
              ),
              child:
              Text('每日應攝取熱量(Kcal)BMR: $bmr',style: TextStyle(fontSize:20)),
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
                      MaterialPageRoute(builder: (context) => Cameramain()));},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
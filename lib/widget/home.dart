import 'package:flutter/material.dart';
import 'package:flutter_quiz/widget/customText.dart';
import 'package:flutter_quiz/widget/nouvellePage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 13.0,
        title: Text('Quiz vrai ou faux'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Card(
                    elevation: 15.0,
                    child: new Container(
                        height: MediaQuery.of(context).size.width / 1.2,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: new Image.asset(
                            "assets/cover.jpg",
                            fit: BoxFit.cover
                        )
                    )
                ),
                new ElevatedButton(
                  onPressed: () => changePage(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0,bottom:10.0,left:25.0,right:25.0)),
                    elevation: MaterialStateProperty.all(8.0),
                  ),
                  child: new CustomText('Commencer le quiz', factor: 1.5),
                ),
              ]
          )
      ),

    );
  }

  void changePage() {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new NewPage();
    }));
  }
}
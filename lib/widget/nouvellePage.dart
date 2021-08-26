import 'package:flutter/material.dart';
import 'package:flutter_quiz/model/Question.dart';
import 'package:flutter_quiz/widget/customText.dart';

class NewPage extends StatefulWidget {

  @override
  _NewPageState createState() => new _NewPageState();

}
class _NewPageState extends State<NewPage> {

  int index = 0;
  int score = 0;
  bool rep;
  Question question;
  List<Question> questionList = [
    new Question('La devise de la Belgique est l\'union fait la force', 'assets/belgique.JPG', true, '' ),
    new Question('La lune va finir par tomber sur terre à cause de la gravité', 'assets/lune.jpg',  false, 'Au contraire la lune s\'éloigne'),
    new Question('La Russie est plus grande en superficie que Pluton', 'assets/russie.jpg', true, ''),
    new Question('Nyctalope est une race naine d\'antilope', 'assets/nyctalope.jpg', false, 'C’est une aptitude à voir dans le noir'),
    new Question('Le Commodore 64 est l\’oridnateur de bureau le plus vendu', 'assets/commodore.jpg', true, ''),
    new Question('Le nom du drapeau des pirates est black skull', 'assets/pirate.png', false, 'Il est appelé Jolly Roger'),
    new Question('Haddock est le nom du chien Tintin', 'assets/tintin.jpg', false, 'C\'est Milou'),
    new Question('La barbe des pharaons était fausse', 'assets/pharaon.jpg', true, 'A l\'époque déjà ils utilisaient des postiches'),
    new Question('Au Québec tire toi une bûche veut dire viens t\'asseoir', 'assets/buche.jpg', true, 'La bûche, fameuse chaise de bucheron'),
    new Question('Le module lunaire Eagle de possédait de 4Ko de Ram', 'assets/eagle.jpg', true, 'Dire que je me plains avec mes 8GO de ram sur mon mac'),
  ];

  @override
  void initState() {
    super.initState();
    question = questionList[index];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Question'),
      ),
      body: new Center(
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget> [
              new Container(
                  height: MediaQuery.of(context).size.height / 35.0,
                  child: new CustomText('Question n°${index+1}', color: Colors.black, factor: 1.4)
              ),
              new Container(
                  height: MediaQuery.of(context).size.height / 35.0,
                  child: new CustomText('Score: $score / $index', color: Colors.black, factor: 1.4)
              ),
              new Card(
                  elevation: 15.0,
                  child: new Container(
                      height: MediaQuery.of(context).size.width / 1.3,
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: new Image.asset(
                          question.image,
                          fit: BoxFit.cover
                      )
                  )
              ),
              new Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new CustomText(question.question, color: Colors.black, factor: 1.4)
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new ElevatedButton(
                    onPressed: () {
                      rep = true;
                      dialogue(rep);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0,bottom:10.0,left:25.0,right:25.0)),
                      elevation: MaterialStateProperty.all(7.0),
                    ),
                    child: new CustomText('Vrai', factor: 1.5),
                  ),
                  new ElevatedButton(
                    onPressed: () {
                      rep = false;
                      dialogue(rep);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0,bottom:10.0,left:25.0,right:25.0)),
                      elevation: MaterialStateProperty.all(7.0),
                    ),
                    child: new CustomText('Faux', factor: 1.5),
                  )
                ],
              )
            ]
        ),
      ),
    );
  }

  String phrase;
  Image image;
  Color color;

  Future<Null> dialogue(bool b) async {
    if(b == question.answer) {
      phrase = "C'est gagné !";
      image = new Image.asset('assets/vrai.jpg', fit: BoxFit.cover);
      color = Colors.green;
      score++;
    } else {
      phrase = "Perdu !";
      image = new Image.asset('assets/faux.jpg', fit: BoxFit.cover);
      color = Colors.red;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15.0),
                  child:
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                            margin: EdgeInsets.only(bottom: 15.0),
                            child: new CustomText(phrase, color: color, factor: 2.0, fontWeight: FontWeight.w700)
                        ),
                        new Card(
                          child: new Container(
                              child: image
                          ),
                        ),
                        new Container(
                            margin: EdgeInsets.only(top: 25.0),
                            height: 60.0,
                            child: new CustomText(question.explication, color: Colors.black, factor: 1.3)
                        ),
                        new ConstrainedBox(
                          constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 1.2),
                          child: new ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              nextQuestion();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0,bottom:10.0,left:25.0,right:25.0)),
                              elevation: MaterialStateProperty.all(7.0),
                            ),
                            child: new CustomText('Au suivant', factor: 1.5),
                          ),
                        )
                      ]
                  )
              )
            ],
          );
        }
    );
  }

  void nextQuestion() {
    if(index < questionList.length - 1) {
      index++;
      setState(() {
        question = questionList[index];
      });
    } else {
      alerte();
    }
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
              contentPadding: EdgeInsets.all(15.0),
              title: new CustomText("C'est fini", color: Colors.blue, factor: 1.3),
              content: new CustomText('Votre Score: $score / $index', color: Colors.black, factor: 1.3),
              actions: <Widget>[
                new ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(buildContext);
                        },
                        child: new CustomText("Accueil", color: Colors.black, factor: 1.3),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0,bottom:10.0,left:25.0,right:25.0)),
                        elevation: MaterialStateProperty.all(7.0),
                      ),
                    )
          ]
          );
        }
    );
  }
}
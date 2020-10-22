import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

/// This is the main method of app, from here execution starts.
void main() => runApp(App());

/// App widget class

class App extends StatelessWidget {
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFFFFFFFF),
        // iconImageAssetPath: 'assets/air-hostess.png',
        bubble: Image.asset('assets/images/imagess.jpg'),
        body: Text(
          'Fit görünmen için boyunun kilonla orantılı olması gerekir',
        ),
        title: Text(
          'İdeal Kilo',
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.blue),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.blue),
        mainImage: Image.asset(
          'assets/images/imagess.jpg',
          height: 280.0,
          width: 280.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFFFFFFFF),
      iconImageAssetPath: 'assets/images/ikincisayfa.png',
      body: Text(
        'Fit görünmek artık çok kolay uygun kiloyu öğren ve hemen ona ulaş ',
      ),
      title: Text('İdeal Kilo'),
      mainImage: Image.asset(
        'assets/images/ikincisayfa.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.blue),
      bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.blue),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IntroViews Flutter', //title of app
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.blue,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}

/// Home Page of our example app.

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final boy = TextEditingController();

  @override
  void dispose() {
    boy.dispose();
    super.dispose();
  }

  int b;
  void kilohesapla(String kilo, String cinsiyet) {
    if (cinsiyet == "Erkek") {
      int a = int.parse(kilo);
      double idealkilo = 50 + (2.3 / 2.54) * (a - 152.4);
      int k = idealkilo.round();
      setState(() {
        b = k;
      });
    } else {
      int a = int.parse(kilo);
      double idealkilo = 50 + (2.3 / 2.54) * (a - 152.4) - 4.5;
      int k = idealkilo.round();
      setState(() {
        b = k;
      });
    }
  }

  List gender = ["Erkek", "Kadın"];

  String select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("İdeal Kilo Hesaplama"),
        ),
        body: Form(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  addRadioButton(0, 'Erkek'),
                  addRadioButton(1, 'Kadın'),
                ],
              ),
              TextField(
                controller: boy,
                autocorrect: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Boyunuzu giriniz',
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text("Uygun Kilonu Öğren"),
                          onPressed: () => kilohesapla(boy.text, select),
                        ),
                      ),
                    )
                  ]),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Olması Gereken Kilonuz: $b"),
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

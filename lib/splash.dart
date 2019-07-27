import 'dart:async';

import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Colors.white, 
        child: Column(
            children: <Widget>[
                Expanded(
                    flex: 3,
                    child : Padding(
                            padding: const EdgeInsets.only(left: 0, top: 100.0, right: 0, bottom: 0),
                            child: new Center(
                            child: new Column(
                                children: <Widget>[
                                    new Image.asset('assets/images/cricket.jpg', height: 400.0,)
                                ], 
                            ),
                           )
                        )
                ),
                Expanded(
                    flex: 1,
                    child : new Center(
                            child: new Column(
                                children: <Widget>[
                                    new Text('Made with'),
                                    new Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0, top: 25.0, right: 0, bottom: 0),
                                      child: new Image.asset('assets/images/flutterlogo.png', height: 50.0,),
                                    )
                                ], 
                            ),
                    ),
                ),
            ]
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'my_main_menu_page.dart';

import 'package:gdg_roma_flutter_app/events/events_route.dart';

void main() {
  runApp(MaterialApp(
    title: 'GDG & WTM Roma',
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/events': (context) => EventsRoute(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 10,
        navigateAfterSeconds: new AfterSplash(),
        image: new Image.asset(
          'images/GDG_Roma_logo.png',
        ),
        title: new Text(
          'Welcome!!',
          style: new TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter GDG Rome"),
        loaderColor: Colors.blue);
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MyMainMenuPage();
  }
}



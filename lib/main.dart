import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splashIconSize: double.maxFinite,
          splash: Image(
            image: AssetImage("images/logo.png"),
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          //splashTransition: SplashTransition.slideTransition,
          //pageTransitionType: PageTransitionType.leftToRight,
          animationDuration: Duration(milliseconds: 5000),
          nextScreen: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

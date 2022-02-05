import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'Screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        title: 'Watduwant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Home(),
        /*routes: {
          '/': (BuildContext context)=>Home(),
        },*/
      );
    });
  }
}


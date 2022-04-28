import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/Screens/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'Screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  check() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.delayed(const Duration(seconds: 3), await LocalDb.isLoggedIn().then((value) {
      setState(() {
        isLoggedIn = value;
        print(value);
      });
    }));
  }

  @override
  void initState(){
    check();
    super.initState();
  }

  /*CheckingSavedData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Future.delayed(const Duration(seconds: 2), () async {
      SharedPreferences prefe = await SharedPreferences.getInstance();
      if (prefe.containsKey('Emaildata')) {
        Get.off(const HomeScreen());
      } else {
        Get.off(LoginScreen());
      }
    }
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        title: 'Watduwant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: isLoggedIn ? LoadingPage(userName: '') : Home(),
      );
    });
  }
}


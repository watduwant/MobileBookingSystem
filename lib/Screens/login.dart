import 'dart:convert';
import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/Screens/loadingPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text('Whatduwant',
            style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w700, fontSize: 23.0.sp, color: Colors.black),),
          ],
        ),
        leading: Container(
          child: ClipOval(
            child: Image.asset('assets/Images/logo_oct1.png'),
          ),
        ),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
              borderRadius: BorderRadius.circular(10.0.sp),
              image: DecorationImage(
                image: CachedNetworkImageProvider("https://source.unsplash.com/yo01Z-9HQAw/1920x1600"),
                alignment: Alignment.topCenter
              )
            ),
          ),
          Container(
            color: Colors.black12,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 35.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.0.sp),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 35.0.sp),
                    alignment: Alignment.center,
                    child: Text('Login',
                    style: TextStyle(fontFamily: 'Amaranth', fontWeight: FontWeight.w600, fontSize: 28.0.sp, color: Colors.black),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.0.sp, 0, 20.0.sp),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
                        style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person_outline),
                        labelStyle: TextStyle(fontSize: 14.0.sp)),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xfff5f5f5),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(
                        color: Colors.black, fontFamily: 'SFUIDisplay'),
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(fontSize: 14.0.sp)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0.sp),
                    child: MaterialButton(
                      onPressed: (){
                        setState(() {
                          loading = true;
                        });
                        login(emailController.text, passwordController.text);
                      },
                      child: loadingOrNot(),
                      color: Colors.black,
                      elevation: 0,
                      textColor: Colors.white,
                      minWidth: 100.w,
                      height: 40.0.sp,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),     
    );
  }

  Widget loadingOrNot(){
    if(loading){
      return CircularProgressIndicator();
    }
    else{
      return Text('Login',
        style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.0.sp,
            fontWeight: FontWeight.w500
        ),
      );
    }
  }

  Future<void> login(String email, String password) async{
    final url = Uri.parse('https://watduwantapi.pythonanywhere.com/api/auth');
    var response = await http.post(
        url,
        headers: {
          'Accept' : 'application/json'
        },
    body: {
          'email' : email,
      'password' : password
    });
    print(response.body);

    setState(() {
      loading = false;
    });
    if(jsonDecode(response.body)['token'] != null){
      AllData.email = email;
      AllData.token = jsonDecode(response.body)['token'];
      LocalDb.setLoginDetails(jsonDecode(response.body)['token'], email);
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingPage(userName: "${emailController.text}")));
    }
    else{
      final snackBar = SnackBar(content: Text('Invalid Login Credentials'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
}
}
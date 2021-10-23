import 'dart:convert';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/views/loadingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Whatduwant',
            style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w700, fontSize: 23, color: Colors.black),),
            //Text('System',
            //style: GoogleFonts.oswald(textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 21)))
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.all(0),
          child: ClipOval(
            child: Image.asset('assets/Images/logo_oct1.png'),
          ),
        ),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage("https://source.unsplash.com/yo01Z-9HQAw/1920x1600"),
                  alignment: Alignment.topCenter
                )
              ),
            ),
          ),
          Container(
            color: Colors.black12,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top:280),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Login',
                        style: TextStyle(fontFamily: 'Amaranth', fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black),),
                        //Text('in',
                        //style: GoogleFonts.prompt(textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black)))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: userNameController,
                        style: TextStyle(
                          color: Colors.black, fontFamily: 'SFUIDisplay'),
                        decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.black,
                        hoverColor: Colors.black,

                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                        labelStyle: TextStyle(fontSize: 15)),
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
                      labelStyle: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed: (){
                        setState(() {
                          loading = true;
                        });
                        login(userNameController.text, passwordController.text);
                      },
                      child: loadingOrNot(),
                      color: Colors.black,
                      elevation: 0,
                      textColor: Colors.white,
                      minWidth: 400,
                      height: 50,
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
            fontSize: 20,
            fontWeight: FontWeight.w500
        ),
      );
    }
  }

  Future<void> login(String userName, String password) async{
    final url = Uri.parse('https://watduwantapi.pythonanywhere.com/api/auth');
    var response = await http.post(
        url,
        headers: {
          'Accept' : 'application/json'
        },
    body: {
          'username' : userName,
      'password' : password
    });

    setState(() {
      loading = false;
    });
    if(jsonDecode(response.body)['token'] != null){
      AllData.username = userName;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingPage(userName: "${userNameController.text}", firstTime : true)));
    }
    else{
      final snackBar = SnackBar(content: Text('Invalid Login Credentials'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
}
}
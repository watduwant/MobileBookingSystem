import 'package:booking_system/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  static Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    print("Token Details of user: ${pref.getString("token")}");

    return pref.getString("token") != null ? true : false;
  }

  static Future loginDetails() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  static Future getEmail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("email");
  }

  static Future<void> setLoginDetails(token, email) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
    pref.setString("email", email);
  }

  static Future<void> logout(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()));
  }
}
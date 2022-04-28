import 'dart:convert';

import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/Models/viewDoctors.dart';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:http/http.dart' as http;

class Doctors {
  static Future<List<ViewDoctors>?> getDoctors() async {
    String token = await LocalDb.loginDetails();
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/viewdoctors'),
          headers: {'Authorization': 'Token $token'});
      final getAllDoctors = viewDoctorsFromJson(result.body);
      return getAllDoctors;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> editVisit(String id, String newDay) async {
    try {
      var result = await http.patch(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsday/$id/'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'},
      body: jsonEncode({
        "Day": newDay
      }));
      print(result.statusCode);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> editTime(String id, String newTime) async {
    try {
      var result = await http.patch(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime/$id/'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'},
          body: jsonEncode({
            "Time": newTime
          }));
      print(result.statusCode);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> editSlots(String id, int newSlots) async {
    try {
      var result = await http.patch(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime/$id/'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'},
          body: jsonEncode({
            "Visit_capacity": newSlots.toString()
          }));
      print(result.statusCode);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
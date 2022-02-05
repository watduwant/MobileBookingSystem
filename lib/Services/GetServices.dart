import 'package:booking_system/Models/servicesDayModel.dart';
import 'package:booking_system/Models/servicesModel.dart';
import 'package:booking_system/Models/servicesTimeModel.dart';
import 'package:http/http.dart' as http;

class AllServices {
  static Future<List<GetAllServices>?> getAllServices() async {
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/services'),
          headers: {'Accept': 'application/json'});
      final getAllServices = getAllServicesFromJson(result.body);
      return getAllServices;
    } catch (e) {
      print(e);
      return null;
    }
  }
  static Future<List<GetAllServicesDay>?> getAllServicesDay() async {
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsday'),
          headers: {'Accept': 'application/json'});
      final getAllServicesDay = getAllServicesDayFromJson(result.body);
      return getAllServicesDay;
    } catch (e) {
      print(e);
      return null;
    }
  }
  static Future<List<GetAllServicesTime>?> getAllServicesTime() async {
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime'),
          headers: {'Accept': 'application/json'});
      final getAllServicesTime = getAllServicesTimeFromJson(result.body);
      return getAllServicesTime;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
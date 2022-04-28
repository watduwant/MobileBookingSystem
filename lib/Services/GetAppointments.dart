import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/Models/appointments.dart';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:http/http.dart' as http;

import '../Models/apppointmentServicesModel.dart';

class AllAppointments {
  static Future<List<List<Appointments>>?> getAllAppointments() async {
    String token = await LocalDb.loginDetails();
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments'),
          headers: {'Authorization': 'Token $token'});
      final getAllAppointments = appointmentsFromJson(result.body);
      return getAllAppointments;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<GetAppointmentServicesModel>?> getAppointmentServices() async {
    String token = await LocalDb.loginDetails();
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointment_services/'),
          headers: {'Authorization': 'Token $token'});
      final getAppointmentServices = getAppointmentServicesModelFromJson(result.body);
      return getAppointmentServices;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
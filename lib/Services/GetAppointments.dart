import 'package:booking_system/Models/appointmentsModel.dart';
import 'package:http/http.dart' as http;

class AllAppointments {
  static Future<List<GetAllAppointments>?> getAllAppointments() async {
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments'),
          headers: {'Accept': 'application/json'});
      final getAllAppointments = getAllAppointmentsFromJson(result.body);
      return getAllAppointments;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
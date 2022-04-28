import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/Models/doctorsModel.dart';
import 'package:http/http.dart' as http;

class AllDoctors {
  static Future<List<GetAllDoctors>?> getAllDoctors() async {
    String token = await LocalDb.loginDetails();
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/doctors'),
          headers: {'Accept': 'application/json'});
      final getAllDoctors = getAllDoctorsFromJson(result.body);
      return getAllDoctors;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
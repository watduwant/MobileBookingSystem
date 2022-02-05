import 'package:booking_system/Models/usersModel.dart';
import 'package:http/http.dart' as http;

class AllProfiles {
  static Future<List<GetAllUsers>?> getAllProfiles() async {
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/users'),
          headers: {'Accept': 'application/json'});
      final getAllProfiles = getAllUsersFromJson(result.body);
      return getAllProfiles;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
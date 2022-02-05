import 'package:booking_system/Models/shopsModel.dart';
import 'package:http/http.dart' as http;

class AllShops {
  static Future<List<GetAllShops>?> getAllShops() async {
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/shops'),
          headers: {'Accept': 'application/json'});
      final getAllShops = getAllShopsFromJson(result.body);
      return getAllShops;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
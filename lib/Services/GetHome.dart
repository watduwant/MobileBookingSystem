import 'dart:convert';

import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:http/http.dart' as http;
import '../Models/homeModel.dart';
import '../data/dataFetcher.dart';

class TheHome {
  static Future<Home?> getHome() async {
    String token = await LocalDb.loginDetails();
    try {
      var result = await http.get(
          Uri.parse('https://watduwantapi.pythonanywhere.com/api/home'),
          headers: {'Authorization': 'Token $token'});
      print(result.body);
      print(jsonDecode(result.body)['doctors'][0]['timing']);
      final getHomeDetails = homeFromJson(result.body);
      return getHomeDetails;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> changeTimings(String openingTime, String closingTime) async{
    AllData.home.openingTime = openingTime;
    AllData.home.closingTime = closingTime;
    final url = Uri.parse(
        'https://watduwantapi.pythonanywhere.com/api/shops/${AllData.home.id}/');
    var response = await http.patch(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Opening_time': openingTime,
          'Closing_time': closingTime
        }));
    print(response.statusCode);
    if(response.statusCode == 200){
      return true;
    }
    else{
      return false;
    }
  }
}
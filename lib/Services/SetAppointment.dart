import 'dart:convert';
import 'package:booking_system/data/UpdateAppointments.dart';
import 'package:http/http.dart' as http;
import 'package:booking_system/data/dataFetcher.dart';

import '../Local DB/localdb.dart';

addAppointment(
    String name,
    int age,
    String sex,
    String phone,
    String doctor,
    String time,
    String day,
    int serviceId
    ) async {
  String token = await LocalDb.loginDetails();
  // int serId = 0;
  /*int rank = 1;
  print('Posting');
  for (var i in AllData.doctorsInfo) {
    if (i['Doctor'] == doctor) {
      for (int j = 0; j < i['Time'].length; j++) {
        if (i['Time'][j].toString() == time) {
          print("GOT IT");
          serId = i['Service ID'][j];
          print(serId);
          rank = i['Appointments'][j].length + 1;
          print('Rank');
          print(rank);
          break;
        }
      }
    }
  }*/
  Map<String, dynamic> data = {
    "Customer": AllData.home.userId,
    "Service": serviceId,
    "PatientName": "$name",
    "Age": age,
    "Sex": "$sex",
    "phone": "$phone",
    "Status": "A",
    // 'Rank': rank,
    "day": "$day",
    "time": "$time"
  };
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  String dataSent = encoder.convert(data);

  final url = Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments/');
  var response = await http.post(url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type' : 'application/json'
      },
      body: dataSent);
  print(response.statusCode);

  await updateAppointments();
}
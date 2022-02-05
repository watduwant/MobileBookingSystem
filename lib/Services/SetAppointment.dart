import 'dart:convert';
import 'package:booking_system/data/UpdateAppointments.dart';
import 'package:http/http.dart' as http;
import 'package:booking_system/data/dataFetcher.dart';

addAppointment(
    String name,
    int age,
    String sex,
    String phone,
    String doctor,
    var time
    ) async {
  int serId = 0;
  int rank = 1;
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
  }

  final url =
  Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments/');
  var response = await http.post(url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Customer': AllData.userId,
        'Service': serId,
        'PatientName': name,
        'Age': age,
        'Sex':sex,
        'phone': phone,
        'Status': 'A',
        'Rank': rank,
      }));
  print(response.statusCode);

  await updateAppointments();
}
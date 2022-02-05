import 'package:booking_system/Models/appointmentsModel.dart';
import 'package:booking_system/Services/GetAppointments.dart';
import 'dataFetcher.dart';

Future<dynamic> updateAppointments() async{
  print('Updating Appointments');
  List<GetAllAppointments>? appointments = await AllAppointments.getAllAppointments();

  print('Data Fetch over');

  for (var detail in AllData.doctorsInfo) {
    var x = List.generate(detail['Time'].length, (_) => []);
    for (var appointment in appointments!) {
      for (var i = 0; i < detail['Service ID'].length; i++) {
        if (appointment.service == detail['Service ID'][i]) {
          Map<String, dynamic> temp = {};
          temp['id'] = appointment.id;
          temp['Customer ID'] = appointment.customer;
          temp['Service ID'] = appointment.service;
          temp['Patient'] = appointment.patientName;
          temp['Age'] = appointment.age;
          temp['Sex'] = appointment.sex;
          temp['Rank'] = appointment.rank;
          temp['Status'] = appointment.status;
          temp['Date'] = appointment.day;
          temp['Contact'] = appointment.phone;
          x[i].add(temp);
        }
      }
    }
    detail['Appointments'] = x;
  }
}
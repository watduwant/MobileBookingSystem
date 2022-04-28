import 'package:booking_system/Models/appointments.dart';
import 'package:booking_system/Models/doctorsInfoModel.dart';
import 'package:booking_system/Models/viewDoctors.dart';

import '../Models/homeModel.dart';

class AllData {
  static int userId = 0;
  static int clinicId = 0;
  static String username = ' ';
  static String pincode = ' ';
  static String token = ' ';
  static String image = ' ';
  static String status = ' ';
  static String clinicName = ' ';
  static String email = ' ';
  static String phone = ' ';
  static String address = ' ';
  static String openingHours = ' ';
  static String closingDay = '';
  static String link = '';
  static List<Map<String, dynamic>> doctorsInfo = [];
  static List<DoctorsInfo> allDoctorsInformation = [];
  static Map<String, List<dynamic>> doctorDetails = {};
  static List<ViewDoctors> doctors = [];
  static List<List<Appointments>> appointments = [];
  static late Home home;
}
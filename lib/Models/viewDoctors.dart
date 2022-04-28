// To parse this JSON data, do
//
//     final viewDoctors = viewDoctorsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ViewDoctors> viewDoctorsFromJson(String str) => List<ViewDoctors>.from(json.decode(str).map((x) => ViewDoctors.fromJson(x)));

String viewDoctorsToJson(List<ViewDoctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewDoctors {
  ViewDoctors({
    required this.id,
    required this.doctor,
    required this.fees,
    required this.serviceDetailsDays,
  });

  int id;
  Doctor doctor;
  int fees;
  List<ServiceDetailsDay> serviceDetailsDays;

  factory ViewDoctors.fromJson(Map<String, dynamic> json) => ViewDoctors(
    id: json["id"],
    doctor: Doctor.fromJson(json["Doctor"]),
    fees: json["Fees"],
    serviceDetailsDays: List<ServiceDetailsDay>.from(json["serviceDetailsDays"].map((x) => ServiceDetailsDay.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Doctor": doctor.toJson(),
    "Fees": fees,
    "serviceDetailsDays": List<dynamic>.from(serviceDetailsDays.map((x) => x.toJson())),
  };
}

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.experience,
    required this.specialization,
    required this.image,
  });

  int id;
  String name;
  int experience;
  String specialization;
  String image;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    name: json["Name"],
    experience: json["Experience"],
    specialization: json["Specialization"],
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": name,
    "Experience": experience,
    "Specialization": specialization,
    "Image": image,
  };
}

class ServiceDetailsDay {
  ServiceDetailsDay({
    required this.id,
    required this.day,
    required this.serviceDetailsDayTimes,
  });

  int id;
  String day;
  List<ServiceDetailsDayTime> serviceDetailsDayTimes;

  factory ServiceDetailsDay.fromJson(Map<String, dynamic> json) => ServiceDetailsDay(
    id: json["id"],
    day: json["Day"],
    serviceDetailsDayTimes: List<ServiceDetailsDayTime>.from(json["serviceDetailsDayTimes"].map((x) => ServiceDetailsDayTime.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Day": day,
    "serviceDetailsDayTimes": List<dynamic>.from(serviceDetailsDayTimes.map((x) => x.toJson())),
  };
}

class ServiceDetailsDayTime {
  ServiceDetailsDayTime({
    required this.id,
    required this.time,
    required this.visitCapacity,
  });

  int id;
  String time;
  int visitCapacity;

  factory ServiceDetailsDayTime.fromJson(Map<String, dynamic> json) => ServiceDetailsDayTime(
    id: json["id"],
    time: json["Time"],
    visitCapacity: json["Visit_capacity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Time": time,
    "Visit_capacity": visitCapacity,
  };
}

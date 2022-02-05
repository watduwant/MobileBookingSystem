// To parse this JSON data, do
//
//     final getAllAppointments = getAllAppointmentsFromJson(jsonString);

import 'dart:convert';

List<GetAllAppointments> getAllAppointmentsFromJson(String str) => List<GetAllAppointments>.from(json.decode(str).map((x) => GetAllAppointments.fromJson(x)));

String getAllAppointmentsToJson(List<GetAllAppointments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllAppointments {
  GetAllAppointments({
    this.id,
    this.customer,
    this.service,
    this.patientName,
    this.age,
    this.sex,
    this.phone,
    this.status,
    this.rank,
    this.day,
    this.time,
  });

  int? id;
  int? customer;
  int? service;
  String? patientName;
  int? age;
  String? sex;
  String? phone;
  String? status;
  int? rank;
  String? day;
  String? time;

  factory GetAllAppointments.fromJson(Map<String, dynamic> json) => GetAllAppointments(
    id: json["id"],
    customer: json["Customer"],
    service: json["Service"],
    patientName: json["PatientName"],
    age: json["Age"],
    sex: json["Sex"],
    phone: json["phone"],
    status: json["Status"],
    rank: json["Rank"],
    day: json["day"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Customer": customer,
    "Service": service,
    "PatientName": patientName,
    "Age": age,
    "Sex": sex,
    "phone": phone,
    "Status": status,
    "Rank": rank,
    "day": day,
    "time": time,
  };
}

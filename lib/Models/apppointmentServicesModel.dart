// To parse this JSON data, do
//
//     final getAppointmentServicesModel = getAppointmentServicesModelFromJson(jsonString);

import 'dart:convert';

List<GetAppointmentServicesModel> getAppointmentServicesModelFromJson(String str) => List<GetAppointmentServicesModel>.from(json.decode(str).map((x) => GetAppointmentServicesModel.fromJson(x)));

String getAppointmentServicesModelToJson(List<GetAppointmentServicesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAppointmentServicesModel {
  GetAppointmentServicesModel({
    this.id,
    this.day,
    this.timing,
    this.doctor,
  });

  int? id;
  String? day;
  List<Timing>? timing;
  Doctor? doctor;

  factory GetAppointmentServicesModel.fromJson(Map<String, dynamic> json) => GetAppointmentServicesModel(
    id: json["id"],
    day: json["Day"],
    timing: List<Timing>.from(json["timing"].map((x) => Timing.fromJson(x))),
    doctor: Doctor.fromJson(json["doctor"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Day": day,
    "timing": List<dynamic>.from(timing!.map((x) => x.toJson())),
    "doctor": doctor!.toJson(),
  };
}

class Doctor {
  Doctor({
    this.id,
    this.name,
    this.experience,
    this.specialization,
    this.image,
  });

  int? id;
  String? name;
  int? experience;
  String? specialization;
  String? image;

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

class Timing {
  Timing({
    this.id,
    this.serviceDetailsDayId,
    this.time,
    this.visitCapacity,
  });

  int? id;
  int? serviceDetailsDayId;
  String? time;
  int? visitCapacity;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    id: json["id"],
    serviceDetailsDayId: json["ServiceDetailsDayID"],
    time: json["Time"],
    visitCapacity: json["Visit_capacity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ServiceDetailsDayID": serviceDetailsDayId,
    "Time": time,
    "Visit_capacity": visitCapacity,
  };
}

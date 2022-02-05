// To parse this JSON data, do
//
//     final getAllServices = getAllServicesFromJson(jsonString);

import 'dart:convert';

List<GetAllServices> getAllServicesFromJson(String str) => List<GetAllServices>.from(json.decode(str).map((x) => GetAllServices.fromJson(x)));

String getAllServicesToJson(List<GetAllServices> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllServices {
  GetAllServices({
    this.id,
    this.clinic,
    this.doctor,
    this.fees,
  });

  int? id;
  int? clinic;
  int? doctor;
  int? fees;

  factory GetAllServices.fromJson(Map<String, dynamic> json) => GetAllServices(
    id: json["id"],
    clinic: json["Clinic"],
    doctor: json["Doctor"],
    fees: json["Fees"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Clinic": clinic,
    "Doctor": doctor,
    "Fees": fees,
  };
}

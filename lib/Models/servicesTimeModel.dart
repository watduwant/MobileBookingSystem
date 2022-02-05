// To parse this JSON data, do
//
//     final getAllServicesTime = getAllServicesTimeFromJson(jsonString);

import 'dart:convert';

List<GetAllServicesTime> getAllServicesTimeFromJson(String str) => List<GetAllServicesTime>.from(json.decode(str).map((x) => GetAllServicesTime.fromJson(x)));

String getAllServicesTimeToJson(List<GetAllServicesTime> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllServicesTime {
  GetAllServicesTime({
    this.id,
    this.serviceDetailsDayId,
    this.time,
    this.visitCapacity,
  });

  int? id;
  int? serviceDetailsDayId;
  String? time;
  int? visitCapacity;

  factory GetAllServicesTime.fromJson(Map<String, dynamic> json) => GetAllServicesTime(
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

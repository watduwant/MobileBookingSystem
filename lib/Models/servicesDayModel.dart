// To parse this JSON data, do
//
//     final getAllServicesDay = getAllServicesDayFromJson(jsonString);

import 'dart:convert';

List<GetAllServicesDay> getAllServicesDayFromJson(String str) => List<GetAllServicesDay>.from(json.decode(str).map((x) => GetAllServicesDay.fromJson(x)));

String getAllServicesDayToJson(List<GetAllServicesDay> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllServicesDay {
  GetAllServicesDay({
    this.id,
    this.serviceId,
    this.day,
  });

  int? id;
  int? serviceId;
  String? day;

  factory GetAllServicesDay.fromJson(Map<String, dynamic> json) => GetAllServicesDay(
    id: json["id"],
    serviceId: json["ServiceID"],
    day: json["Day"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ServiceID": serviceId,
    "Day": day,
  };
}

// To parse this JSON data, do
//
//     final doctorsInfo = doctorsInfoFromJson(jsonString);

import 'dart:convert';

List<DoctorsInfo> doctorsInfoFromJson(String str) => List<DoctorsInfo>.from(json.decode(str).map((x) => DoctorsInfo.fromJson(x)));

String doctorsInfoToJson(List<DoctorsInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorsInfo {
  DoctorsInfo({
    required this.doctor,
    required this.specialization,
    required this.id,
    required this.image,
    required this.experience,
    required this.serviceId,
    required this.serviceDayId,
    required this.serviceTimeId,
    required this.time,
    required this.fees,
    required this.slots,
    required this.day,
  });

  String doctor;
  String specialization;
  int id;
  String image;
  int experience;
  List<int> serviceId;
  List<int> serviceDayId;
  List<int> serviceTimeId;
  List<String> time;
  List<int> fees;
  List<int> slots;
  List<String> day;

  factory DoctorsInfo.fromJson(Map<String, dynamic> json) => DoctorsInfo(
    doctor: json["Doctor"],
    specialization: json["Specialization"],
    id: json["id"],
    image: json["Image"],
    experience: json["Experience"],
    serviceId: List<int>.from(json["Service ID"].map((x) => x)),
    serviceDayId: List<int>.from(json["Service Day ID"].map((x) => x)),
    serviceTimeId: List<int>.from(json["Service Time ID"].map((x) => x)),
    time: List<String>.from(json["Time"].map((x) => x)),
    fees: List<int>.from(json["Fees"].map((x) => x)),
    slots: List<int>.from(json["Slots"].map((x) => x)),
    day: List<String>.from(json["Day"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Doctor": doctor,
    "Specialization": specialization,
    "id": id,
    "Image": image,
    "Experience": experience,
    "Service ID": List<dynamic>.from(serviceId.map((x) => x)),
    "Service Day ID": List<dynamic>.from(serviceDayId.map((x) => x)),
    "Service Time ID": List<dynamic>.from(serviceTimeId.map((x) => x)),
    "Time": List<dynamic>.from(time.map((x) => x)),
    "Fees": List<dynamic>.from(fees.map((x) => x)),
    "Slots": List<dynamic>.from(slots.map((x) => x)),
    "Day": List<dynamic>.from(day.map((x) => x)),
  };
}

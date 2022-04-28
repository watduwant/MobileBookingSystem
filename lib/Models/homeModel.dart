// To parse this JSON data, do
//
//     final home = homeFromJson(jsonString);

import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  Home({
    this.id,
    this.name,
    this.userId,
    this.shopOwner,
    this.image,
    this.interiorImage,
    this.status,
    this.shopUrl,
    this.openingTime,
    this.closingTime,
    this.doctors,
  });

  int? id;
  String? name;
  int? userId;
  int? shopOwner;
  String? image;
  String? interiorImage;
  String? status;
  String? shopUrl;
  String? openingTime;
  String? closingTime;
  List<Doctor>? doctors;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    id: json["id"],
    name: json["Name"],
    userId: json["user_id"],
    shopOwner: json["Shop_owner"],
    image: json["Image"],
    interiorImage: json["Interior_image"],
    status: json["Status"],
    shopUrl: json["Shop_url"],
    openingTime: json["Opening_time"],
    closingTime: json["Closing_time"],
    doctors: List<Doctor>.from(json["doctors"].map((x) => Doctor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": name,
    "user_id": userId,
    "Shop_owner": shopOwner,
    "Image": image,
    "Interior_image": interiorImage,
    "Status": status,
    "Shop_url": shopUrl,
    "Opening_time": openingTime,
    "Closing_time": closingTime,
    "doctors": List<dynamic>.from(doctors!.map((x) => x.toJson())),
  };
}

class Doctor {
  Doctor({
    this.doctor,
    this.timing,
  });

  DoctorClass? doctor;
  List<Timing>? timing;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    doctor: DoctorClass.fromJson(json["Doctor"]),
    timing: json["timing"] != null ? List<Timing>.from(json["timing"].map((x) => Timing.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "Doctor": doctor!.toJson(),
    "timing": timing != null ? List<dynamic>.from(timing!.map((x) => x.toJson())) : null,
  };
}

class DoctorClass {
  DoctorClass({
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

  factory DoctorClass.fromJson(Map<String, dynamic> json) => DoctorClass(
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
    this.time,
    this.visitCapacity,
  });

  int? id;
  String? time;
  int? visitCapacity;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
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

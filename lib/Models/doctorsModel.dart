// To parse this JSON data, do
//
//     final getAllDoctors = getAllDoctorsFromJson(jsonString);

import 'dart:convert';

List<GetAllDoctors> getAllDoctorsFromJson(String str) => List<GetAllDoctors>.from(json.decode(str).map((x) => GetAllDoctors.fromJson(x)));

String getAllDoctorsToJson(List<GetAllDoctors> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllDoctors {
  GetAllDoctors({
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

  factory GetAllDoctors.fromJson(Map<String, dynamic> json) => GetAllDoctors(
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

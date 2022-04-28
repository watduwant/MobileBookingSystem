// To parse this JSON data, do
//
//     final appointments = appointmentsFromJson(jsonString);

import 'dart:convert';

List<List<Appointments>> appointmentsFromJson(String str) => List<List<Appointments>>.from(json.decode(str).map((x) => List<Appointments>.from(x.map((x) => Appointments.fromJson(x)))));

String appointmentsToJson(List<List<Appointments>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class Appointments {
  Appointments({
    this.id,
    this.doctor,
    this.customer,
    this.timing,
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
  Doctor? doctor;
  int? customer;
  Timing? timing;
  String? patientName;
  int? age;
  String? sex;
  String? phone;
  String? status;
  int? rank;
  String? day;
  String? time;

  factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
    id: json["id"],
    doctor: Doctor.fromJson(json["doctor"]),
    customer: json["Customer"],
    timing: Timing.fromJson(json["timing"]),
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
    "doctor": doctor!.toJson(),
    "Customer": customer,
    "timing": timing!.toJson(),
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

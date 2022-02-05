// To parse this JSON data, do
//
//     final getAllUsers = getAllUsersFromJson(jsonString);

import 'dart:convert';

List<GetAllUsers> getAllUsersFromJson(String str) => List<GetAllUsers>.from(json.decode(str).map((x) => GetAllUsers.fromJson(x)));

String getAllUsersToJson(List<GetAllUsers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllUsers {
  GetAllUsers({
    this.id,
    this.email,
    this.profilePic,
    this.mobile,
    this.status,
    this.city,
    this.pincode,
  });

  int? id;
  String? email;
  String? profilePic;
  String? mobile;
  String? status;
  String? city;
  String? pincode;

  factory GetAllUsers.fromJson(Map<String, dynamic> json) => GetAllUsers(
    id: json["id"],
    email: json["email"],
    profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    status: json["status"],
    city: json["city"],
    pincode: json["pincode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "profile_pic": profilePic == null ? null : profilePic,
    "mobile": mobile == null ? null : mobile,
    "status": status,
    "city": city,
    "pincode": pincode,
  };
}

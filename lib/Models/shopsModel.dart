// To parse this JSON data, do
//
//     final getAllShops = getAllShopsFromJson(jsonString);

import 'dart:convert';

List<GetAllShops> getAllShopsFromJson(String str) => List<GetAllShops>.from(json.decode(str).map((x) => GetAllShops.fromJson(x)));

String getAllShopsToJson(List<GetAllShops> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllShops {
  GetAllShops({
    this.id,
    this.name,
    this.shopOwner,
    this.address,
    this.status,
    this.offDay,
    this.interiorImage,
    this.image,
    this.openingTime,
    this.closingTime,
    this.shopUrl,
  });

  int? id;
  String? name;
  int? shopOwner;
  String? address;
  String? status;
  String? offDay;
  String? interiorImage;
  String? image;
  String? openingTime;
  String? closingTime;
  String? shopUrl;

  factory GetAllShops.fromJson(Map<String, dynamic> json) => GetAllShops(
    id: json["id"],
    name: json["Name"],
    shopOwner: json["Shop_owner"],
    address: json["Address"],
    status: json["Status"],
    offDay: json["OffDay"],
    interiorImage: json["Interior_image"],
    image: json["Image"],
    openingTime: json["Opening_time"],
    closingTime: json["Closing_time"],
    shopUrl: json["Shop_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Name": name,
    "Shop_owner": shopOwner,
    "Address": address,
    "Status": status,
    "OffDay": offDay,
    "Interior_image": interiorImage,
    "Image": image,
    "Opening_time": openingTime,
    "Closing_time": closingTime,
    "Shop_url": shopUrl,
  };
}

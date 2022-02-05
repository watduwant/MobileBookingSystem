import 'dart:convert';
import 'package:booking_system/Models/appointmentsModel.dart';
import 'package:booking_system/Models/doctorsModel.dart';
import 'package:booking_system/Models/servicesDayModel.dart';
import 'package:booking_system/Models/servicesModel.dart';
import 'package:booking_system/Models/servicesTimeModel.dart';
import 'package:booking_system/Models/shopsModel.dart';
import 'package:booking_system/Models/usersModel.dart';
import 'package:booking_system/Services/GetAppointments.dart';
import 'package:booking_system/Services/GetDoctors.dart';
import 'package:booking_system/Services/GetProfile.dart';
import 'package:booking_system/Services/GetServices.dart';
import 'package:booking_system/Services/GetShops.dart';
import 'package:http/http.dart' as http;
import 'package:booking_system/data/dataFetcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'details_page_home.dart';

class LoadingPage extends StatefulWidget {
  final String userName;
  var firstTime;
  LoadingPage({required this.userName, this.firstTime = false});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    fetchProfileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(height: 10.0,),
          Center(
            child: Text('Fetching Data', style: TextStyle(
                fontFamily: 'Amaranth',
                fontSize: 24),),
          )
        ],
      ),
    );
  }

  String getDate(int num){
    if(num == 1){
      return 'Sunday';
    }
    else if(num == 2){
      return 'Monday';
    }
    else if(num == 3){
      return 'Tuesday';
    }
    else if(num == 4){
      return 'Wednesday';
    }
    else if(num == 5){
      return 'Thursday';
    }
    else if(num == 6){
      return 'Friday';
    }
    else{
      return 'Saturday';
    }
  }

  Future<void> fetchProfileDetails() async {
    // Fetch user id
    /*var users = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/users'),
        headers: {'Accept': 'application/json'});*/

    List<GetAllUsers>? users = await AllProfiles.getAllProfiles();

    for (var user in users!) {
      if (user.email == AllData.email) {
        AllData.userId = user.id!;
        AllData.phone = user.mobile!;
        AllData.email = user.email!;
        AllData.pincode = user.pincode!;
        break;
      }
    }

    // Getting shop details
    List<GetAllShops>? shops = await AllShops.getAllShops();

    for (var shop in shops!) {
      if (shop.shopOwner == AllData.userId) {
        AllData.clinicId = shop.id!;
        AllData.clinicName = shop.name!;
        AllData.address = shop.address!;
        AllData.status = shop.status!;
        AllData.image = shop.image!;
        AllData.closingDay = getDate(int.parse(shop.offDay!));
        AllData.link = shop.shopUrl!;
        //AllData.openingHours = '${shop['opening_time']} - ${shop['closing_time']}';
        AllData.openingHours = '${DateFormat.jm().format(DateTime.parse('2021-01-01 ${shop.openingTime!}'))} - ${DateFormat.jm().format(DateTime.parse('2021-01-01 ${shop.closingTime!}'))}';
        break;
      }
    }

    print('Hello');
    // Getting profile details
    /*var profiles = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/users'),
        headers: {'Accept': 'application/json'});

    for (var profile in jsonDecode(profiles.body)) {
      if (profile['user'] == AllData.userId) {
        AllData.phone = profile['phone'];
        AllData.email = profile['email'];
        AllData.address = AllData.address + ' ${profile['pincode']}';
        break;
      }
    }

    print("Done");*/

    List<GetAllDoctors>? doctors = await AllDoctors.getAllDoctors();
    List<GetAllServices>? services = await AllServices.getAllServices();
    List<GetAllServicesTime>? servicesTime = await AllServices.getAllServicesTime();
    List<GetAllServicesDay>? servicesDay = await AllServices.getAllServicesDay();
    List<GetAllAppointments>? appointments = await AllAppointments.getAllAppointments();

    print('Data Fetch done');
    AllData.doctorsInfo = [];

    for(var service in services!){
      if(service.clinic == AllData.clinicId){
        print('Clinic found');
        for(var doctor in doctors!){
          print(doctor.id);
          if(service.doctor == doctor.id){
            print('Doctor found');
            for(var serviceDay in servicesDay!){
              if(serviceDay.serviceId == service.id){
                print('Service Day found');
                for(var serviceTime in servicesTime!){
                  if(serviceTime.serviceDetailsDayId == serviceDay.id){
                    print('Service Time found');
                    bool exist = false;
                    for (var i in AllData.doctorsInfo) {
                      if (i['Doctor'] == doctor.name) {
                        i['Service ID'].add(service.id);
                        i['Time'].add(serviceTime.time);
                        i['Fees'].add(service.fees);
                        i['Slots'].add(serviceTime.visitCapacity);
                        i['Service Day ID'].add(serviceDay.id);
                        i['Service Time ID'].add(serviceTime.id);
                        i['Day'].add(convertLetterTo3Letters(serviceDay.day!));
                        exist = true;
                        break;
                      }
                    }
                    if (!exist) {
                      Map<String, dynamic> temp = {};
                      temp['Doctor'] = doctor.name;
                      temp['Specialization'] = doctor.specialization;
                      temp['id'] = doctor.id;
                      temp['Image'] = doctor.image;
                      temp['Experience'] = doctor.experience;
                      temp['Service ID'] =
                          List.filled(1, service.id, growable: true);
                      temp['Service Day ID'] =
                          List.filled(1, serviceDay.id, growable: true);
                      temp['Service Time ID'] =
                          List.filled(1, serviceTime.id, growable: true);
                      temp['Time'] =
                          List.filled(1, serviceTime.time, growable: true);
                      temp['Fees'] =
                          List.filled(1, service.fees, growable: true);
                      temp['Slots'] = List.filled(
                          1, serviceTime.visitCapacity,
                          growable: true);
                      temp['Day'] = List.filled(
                          1, convertLetterTo3Letters(serviceDay.day!),
                          growable: true);
                      AllData.doctorsInfo.add(temp);
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    /*for (var service in jsonDecode(services.body)) {
      if (service['Clinic'] == AllData.clinicId) {
        for (var doctor in jsonDecode(doctors.body)) {
          if (service['Doctor'] == doctor['id']) {
            for (var serviceDetail in jsonDecode(serviceDetails.body)) {
              if (serviceDetail['ServiceID'] == service['id']) {
                bool exist = false;
                for (var i in AllData.doctorsInfo) {
                  if (i['Doctor'] == doctor['Name']) {
                    i['Service id'].add(service['id']);
                    i['Time'].add(serviceDetail['Time']);
                    i['Fees'].add(service['Fees']);
                    i['Slots'].add(serviceDetail['Visit_capacity']);
                    i['ServiceID'].add(serviceDetail['id']);
                    i['Day'].add(convertLetterTo3Letters(service['day']));
                    exist = true;
                    break;
                  }
                }
                if (!exist) {
                  Map<String, dynamic> temp = {};
                  temp['Doctor'] = doctor['Name'];
                  temp['Specialization'] = doctor['Specialization'];
                  temp['id'] = doctor['id'];
                  temp['Image'] = doctor['Image'];
                  temp['Experience'] = doctor['Experience'];
                  temp['ServiceID'] =
                      List.filled(1, serviceDetail['id'], growable: true);
                  temp['Service id'] =
                      List.filled(1, service['id'], growable: true);
                  temp['Time'] =
                      List.filled(1, serviceDetail['Time'], growable: true);
                  temp['Fees'] =
                      List.filled(1, service['Fees'], growable: true);
                  temp['Slots'] = List.filled(
                      1, serviceDetail['Visit_capacity'],
                      growable: true);
                  temp['Day'] = List.filled(
                      1, convertLetterTo3Letters(service['day']),
                      growable: true);
                  AllData.doctorsInfo.add(temp);
                }
              }
            }
          }
        }
      }
    }*/

    print('Getting Appointments now');
    //print(AllData.doctorsInfo);
    for (var detail in AllData.doctorsInfo) {
      var x = List.generate(detail['Time'].length, (_) => []);
      for (var appointment in appointments!) {
        for (var i = 0; i < detail['Service ID'].length; i++) {
          if (appointment.service == detail['Service ID'][i]) {
            Map<String, dynamic> temp = {};
            temp['id'] = appointment.id;
            temp['Customer ID'] = appointment.customer;
            temp['Service ID'] = appointment.service;
            temp['Patient'] = appointment.patientName;
            temp['Age'] = appointment.age;
            temp['Sex'] = appointment.sex;
            temp['Rank'] = appointment.rank;
            temp['Status'] = appointment.status;
            temp['Date'] = appointment.day;
            temp['Contact'] = appointment.phone;
            x[i].add(temp);
          }
        }
      }
      detail['Appointments'] = x;
    }

    debugPrint(AllData.doctorsInfo.toString(),wrapWidth: 1000);
    print(AllData.doctorsInfo.length);
    setState(() {
      //visibleHome = true;
      Navigator.of(context).pop();
      if(widget.firstTime){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHome(userName: "${widget.userName}",)));
      }
    });
  }

  String convertLetterTo3Letters(String d) {
    if (d == '1') {
      return 'Mon';
    } else if (d == '2') {
      return 'Tue';
    } else if (d == '3') {
      return 'Wed';
    } else if (d == '4') {
      return 'Thu';
    } else if (d == '5') {
      return 'Fri';
    } else if (d == '6') {
      return 'Sat';
    } else {
      return 'Sun';
    }
  }

}

import 'dart:convert';
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
    var users = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/users'),
        headers: {'Accept': 'application/json'});

    for (var user in jsonDecode(users.body)) {
      if (user['username'] == AllData.username) {
        AllData.userId = user['id'];
        break;
      }
    }

    // Getting shop details
    var shops = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/shops'),
        headers: {'Accept': 'application/json'});

    for (var shop in jsonDecode(shops.body)) {
      if (shop['shop_owner'] == AllData.userId) {
        AllData.clinicId = shop['id'];
        AllData.clinicName = shop['Name'];
        AllData.address = shop['Address'];
        AllData.status = shop['Status'];
        AllData.image = shop['Image'];
        AllData.closingDay = getDate(int.parse(shop['offDay']));
        //AllData.openingHours = '${shop['opening_time']} - ${shop['closing_time']}';
        AllData.openingHours = '${DateFormat.jm().format(DateTime.parse('2021-01-01 ${shop['opening_time']}'))} - ${DateFormat.jm().format(DateTime.parse('2021-01-01 ${shop['closing_time']}'))}';
        break;
      }
    }

    print('Hello');
    // Getting profile details
    var profiles = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/profiles'),
        headers: {'Accept': 'application/json'});

    for (var profile in jsonDecode(profiles.body)) {
      if (profile['user'] == AllData.userId) {
        AllData.phone = profile['phone'];
        AllData.email = profile['email'];
        AllData.address = AllData.address + ' ${profile['pincode']}';
        break;
      }
    }

    print("Done");

    var services = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/services'),
        headers: {'Accept': 'application/json'});
    var doctors = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/doctors'),
        headers: {'Accept': 'application/json'});
    var serviceDetails = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetails'),
        headers: {'Accept': 'application/json'});
    var appointmentDetails = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments'),
        headers: {'Accept': 'application/json'});

    AllData.doctorsInfo = [];
    for (var service in jsonDecode(services.body)) {
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
    }

    for (var detail in AllData.doctorsInfo) {
      var x = List.generate(detail['Time'].length, (_) => []);
      for (var appointment in jsonDecode(appointmentDetails.body)) {
        for (var i = 0; i < detail['ServiceID'].length; i++) {
          if (appointment['Service'] == detail['ServiceID'][i]) {
            Map<String, dynamic> temp = {};
            temp['id'] = appointment['id'];
            temp['Customer ID'] = appointment['Customer'];
            temp['Service ID'] = appointment['Service'];
            temp['Patient'] = appointment['PatientName'];
            temp['Age'] = appointment['Age'];
            temp['Sex'] = appointment['Sex'];
            temp['Rank'] = appointment['Rank'];
            temp['Status'] = appointment['Status'];
            temp['Date'] = appointment['date'];
            temp['Contact'] = appointment['phone'];
            x[i].add(temp);
          }
        }
      }
      detail['Appointments'] = x;
    }

    print(AllData.doctorsInfo);
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

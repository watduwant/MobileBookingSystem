import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/Models/appointments.dart';
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
import 'package:booking_system/data/dataFetcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../Services/GetHome.dart';
import 'home.dart';

class LoadingPage extends StatefulWidget {
  String userName;
  LoadingPage({required this.userName});

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
          SizedBox(height: 10.0.sp,),
          Center(
            child: Text('Fetching Data', style: TextStyle(
                fontFamily: 'Amaranth',
                fontSize: 20.0.sp),),
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
    print('Hello!');
    widget.userName = await LocalDb.getEmail();
    print(widget.userName);
    AllData.email = widget.userName;
    print('Hi');

    await TheHome.getHome().then((value) {
      print(value);
      if (value != null) {
        setState(() {
          AllData.home = value;
          print('Done!');
        });
      }
    });

    setState(() {
      print('DOne');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHome(userName: "${widget.userName}",)));
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

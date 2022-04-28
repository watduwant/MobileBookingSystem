import 'dart:convert';
import 'package:booking_system/Services/SetAppointment.dart';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

import '../Models/apppointmentServicesModel.dart';
import '../Services/GetAppointments.dart';

class AddPatient extends StatefulWidget {
  final String userName;
  AddPatient({required this.userName});

  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  TextEditingController dateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController doctorController = TextEditingController();
  TextEditingController timingController = TextEditingController();
  String _selectedSex = 'Choose Gender';
  var setDate = DateTime.now();
  bool loading = false;

  List<GetAppointmentServicesModel>? setAppointment = [];
  String chosenDate = '';

  String chosenDay =
      DateFormat('EEEE').format(DateTime.now()).toString().substring(0, 3);

  List<String> _slot = ["Choose Timing"];
  String _selectedDoctor = "Choose Doctor";
  String _selectedSlot = "Choose Timing";
  Map<String, String> _timeIn12And24 = {
    "Choose Timing" : '0'
  };
  bool postTime = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: Text(
              'Hello ${widget.userName.toUpperCase()} !',
              textAlign: TextAlign.end,
              style: TextStyle( fontFamily: 'Amaranth', fontSize: 12.0.sp, color: Colors.black),
            ),
          ),
          SizedBox(width: 10.0,)
        ],
        leading: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(0),
            child: ClipOval(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 2.0.sp, horizontal: 5.0.sp),
            child: Center(
              child: Text(
                'Add Patient',
                style: TextStyle(
                    fontFamily: 'Amaranth',
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: TextField(
              controller: dateController,
              readOnly: true,
              onTap: () async {
                var dateChosen = await showDatePicker(
                  context: context,
                  initialDate: setDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 21)),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: Colors.black,
                          onPrimary: Colors.white70,
                          surface: Colors.white70,
                          onSurface: Colors.black87,
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child ?? Text(""),
                    );
                  },
                );

                setDate = dateChosen!;
                dateController.text = dateChosen.toString().substring(0, 10);
                chosenDay = DateFormat('EEEE')
                    .format(dateChosen)
                    .toString()
                    .substring(0, 3);

                setState(() {
                  chosenDate = convert3LettersToLetter(chosenDay);
                  _slot = ["Choose Timing"];
                  _selectedDoctor = "Choose Doctor";
                  _selectedSlot = "Choose Timing";
                  postTime = false;
                  findDoctorNamesAndSlots();
                });
              },
              style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0.sp),
              decoration: InputDecoration(
                  hintText: 'Date',
                  hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: TextFormField(
              controller: nameController,
              style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0.sp),
              decoration: InputDecoration(
                  hintText: 'Patient Name',
                  hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0.sp),
              decoration: InputDecoration(
                  hintText: 'Age',
                  hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0.sp),
              decoration: InputDecoration(
                  hintText: 'Contact Number',
                  hintStyle: TextStyle(fontFamily: 'Roboto', fontSize: 13.0.sp),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: DropdownButtonFormField(
                onChanged: (val) => _selectedSex = val.toString(),
                value: _selectedSex,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
                items: ['Choose Gender', 'Male', 'Female']
                    .map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val, style: TextStyle(fontFamily: 'Roboto', fontSize: 17),));
                }).toList()),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: DropdownButtonFormField(
                onChanged: (val) => onSelectedDoctor(val.toString()),
                value: _selectedDoctor,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.sp)),
                items: AllData.doctorDetails.keys
                    .map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val,style: TextStyle(fontFamily: 'Roboto', fontSize: 17),));
                }).toList()),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: DropdownButtonFormField(
                onChanged: (value) {
                  _selectedSlot = value.toString();
                  setState(() {
                    postTime = true;
                  });
                },
                value: _selectedSlot,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
                items: _slot.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val, style: TextStyle(fontFamily: 'Roboto', fontSize: 17),));
                }).toList()),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0.sp, left: 15.0.sp, right: 15.0.sp),
            child: Container(
              height: 40.0.sp,
              width: 100.0.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0.sp),
                color: Colors.black,
              ),
              padding: EdgeInsets.all(5.0.sp),
              child: MaterialButton(
                onPressed: () {
                  if (postTime) {
                    setState(() {
                      loading = true;
                    });
                    posting();
                  } else {
                    final snackBar = SnackBar(
                        content:
                            Text('Please complete filling the form first'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Center(child: loadingOrNot()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingOrNot() {
    if (loading) {
      return CircularProgressIndicator();
    } else {
      return Text(
        "Submit",
        style: TextStyle(
                fontSize: 16.0.sp,
            fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                color: Colors.white),
      );
    }
  }

  void onSelectedDoctor(String value) {
    setState(() {
      _selectedSlot = "Choose Timing";
      _slot = ["Choose Timing"];
      _timeIn12And24 = {
        "Choose Timing" : '0'
      };
      _selectedDoctor = value;
      for (var i in AllData.doctorDetails[value]!) {
        print(i);
        _slot.add(DateFormat.jm().format(DateTime.parse('2021-01-01 ${i.toString()}')));
        _timeIn12And24[DateFormat.jm().format(DateTime.parse('2021-01-01 ${i.toString()}'))] = i;
      }
    });
  }

  posting() async {
    /*int serId = 0;
    int rank = 1;
    print('Posting');
    print(_selectedSlot);
    var time24 = _timeIn12And24[_selectedSlot];
    print(time24);
    for (var i in AllData.doctorsInfo) {
      if (i['Doctor'] == _selectedDoctor) {
        for (int j = 0; j < i['Time'].length; j++) {
          if (i['Time'][j].toString() == time24) {
            print("GOT IT");
            serId = i['ServiceID'][j];
            print(serId);
            rank = i['Appointments'][j].length + 1;
            print('Rank');
            print(rank);
            break;
          }
        }
      }
    }

    final url =
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments/');
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'Customer': AllData.userId,
          'Service': serId,
          'PatientName': nameController.text,
          'Age': int.parse(ageController.text),
          'Sex': _selectedSex[0],
          'phone': phoneController.text,
          'Status': 'A',
          'Rank': rank,
        }));
    print(response.statusCode);*/

    /*var appointmentDetails = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments'),
        headers: {'Accept': 'application/json'});
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
    }*/
    int serviceId = 0;
    for(var i in setAppointment!){
      if(i.day == chosenDate){
        if(i.doctor!.name == _selectedDoctor){
          for(var j in i.timing!){
            if(j.time ==  _timeIn12And24[_selectedSlot]){
              serviceId = j.id!;
            }
          }
        }
      }
    }
    await addAppointment(
        nameController.text, int.parse(ageController.text), _selectedSex[0], phoneController.text, _selectedDoctor, _timeIn12And24[_selectedSlot]!, dateController.text, serviceId);

    setState(() {
      loading = false;
    });

    final snackBar = SnackBar(
      content:
      Text('Appointment has been set', style: TextStyle(fontFamily: 'Roboto',color: Colors.white, fontSize: 16.0),),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.of(context).pop();
  }

  findDoctorNamesAndSlots() async {
    AllData.doctorDetails = {
      "Choose Doctor": ["Choose Timing"]
    };
    _slot = ["Choose Timing"];
    _selectedDoctor = "Choose Doctor";
    _selectedSlot = "Choose Timing";
    print(chosenDay);

    for(var i in setAppointment!){
      if(i.day == chosenDate){
        var x = [];
        for(var j in i.timing!){
          x.add(j.time);
        }
        if(x.length != 0){
          AllData.doctorDetails[i.doctor!.name!] = x;
        }
      }
    }
    /*
    for (int i = 0; i < AllData.doctorsInfo.length; i++) {
      var x = [];
      for (int j = 0; j < AllData.doctorsInfo[i]['Day'].length; j++) {
        if (AllData.doctorsInfo[i]['Day'][j] == chosenDay) {
          x.add(AllData.doctorsInfo[i]['Time'][j]);
        }
      }
      if (x.length != 0) {
        AllData.doctorDetails[AllData.doctorsInfo[i]['Doctor']] = x;
      }
    }*/
    print(AllData.doctorDetails);
    setState(() {});
  }

  fetchData() async {
    await AllAppointments.getAppointmentServices().then((value) {
      if (value != null) {
        setState(() {
          setAppointment = value;
        });
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

  String convert3LettersToLetter(String d) {
    if (d == 'Mon') {
      return '1';
    } else if (d == 'Tue') {
      return '2';
    } else if (d == 'Wed') {
      return '3';
    } else if (d == 'Thu') {
      return '4';
    } else if (d == 'Fri') {
      return '5';
    } else if (d == 'Sat') {
      return '6';
    } else {
      return '7';
    }
  }

}

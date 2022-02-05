import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/Screens/theDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'add_patient.dart';
import 'loadingPage.dart';

class DetailDoctor extends StatefulWidget {
  final String userName;
  DetailDoctor({required this.userName});

  @override
  _DetailDoctorState createState() => _DetailDoctorState();
}

class _DetailDoctorState extends State<DetailDoctor> {
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController doctorName = TextEditingController();
  List<bool> edits = List.filled(AllData.doctorsInfo.length, false);
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  bool addingDay = false;
  String addDayVisit = 'Select Day';
  List<String> addDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Select Day'];
  String addDayTime = 'Select Time';
  String addDaySlots = 'Select Slots';

  /*late Timer _timer;

  @override
  void initState() {
    updateAppointments();
    _timer =
        new Timer.periodic(Duration(seconds: 45), (_) => updateAppointments());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
*/
  TextEditingController timing = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //days.remove(AllData.closingDay.substring(0, 3));
    return Scaffold(
      drawer: TheDrawer(
        userName: widget.userName,
      ),
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
          SizedBox(width: 10.0.sp,)
        ],
        leading: Builder(
          builder: (context) => ClipOval(
            child: IconButton(
              icon: Image.asset('assets/Images/logo_oct1.png'),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: ()  async {
          //Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingPage(userName: "${widget.userName}",)));
        },
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0.sp,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: AllData.doctorsInfo.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: Column(
                              children: [
                                Container(
                                  height: 27.w,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0.sp),
                                        child: Container(
                                        width: 25.w,
                                        child: ClipOval(
                                          child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: CachedNetworkImageProvider(
                                                    AllData.doctorsInfo[index]
                                                    ['Image'],
                                                  ))),
                                        )),
                                  ),),
                                  Container(
                                    width: 66.w,
                                    //height: MediaQuery.of(context).size.width *3/4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: FittedBox(
                                            child: Text(
                                              AllData.doctorsInfo[index]['Doctor'],
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Amaranth',
                                                  fontSize: 14.0.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                            fit: BoxFit.scaleDown,
                                          )
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10.0.sp,),
                                            Expanded(child: Text(
                                              'Specialization : ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 11.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),),
                                            SizedBox(width: 10.0.sp,),
                                            Expanded(child: Text(
                                              AllData.doctorsInfo[index]
                                              ['Specialization'],
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 11.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10.0.sp,),
                                            Expanded(child: Text(
                                              'Experience : ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),),
                                            SizedBox(width: 10.0.sp,),
                                            Expanded(child: Text(
                                              '${AllData.doctorsInfo[index]['Experience'].toString()} years',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 10.0.sp,),
                                            Expanded(child: Text(
                                              'Fees : ',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),),
                                            SizedBox(width: 10.0.sp,),
                                            Expanded(child: Text(
                                              '₹ ${AllData.doctorsInfo[index]['Fees'][0]}',
                                              //textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),)
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                                SizedBox(
                              height: 10.0.sp,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text('Visit', style: TextStyle(
                                        fontFamily: 'Amaranth',
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,)),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text('Time', style: TextStyle(
                                        fontFamily: 'Amaranth',
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,)),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Text('Slots', style: TextStyle(
                                        fontFamily: 'Amaranth',
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,)),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: GestureDetector(
                                        child: Icon(Icons.edit),
                                        onTap: () {
                                          setState(() {
                                            edits[index] = !edits[index];
                                            //dialog(index)
                                          });
                                        },
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10.0.sp,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Center(child: _visit(index),),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(child: _time(index)),
                                ),
                                Expanded(
                                    flex: 3, child: Center(child: _slots(index))),
                                Expanded(flex: 1, child: Text(''))
                              ],
                            ),
                            Visibility(
                              visible: edits[index],
                              child: Row(
                              children: [
                                SizedBox(width: 15.0.sp,),
                                Expanded(
                                    flex: 2,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        setState(() {
                                          _addDay(index);
                                        });
                                      },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      color: Colors.black,
                                      child: addDay()
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Text(''))
                              ],
                            ),),
                            SizedBox(
                              height: 40.0.sp,
                            ),
                          ],
                        ));
                      }),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPatient(
                        userName: widget.userName,
                      )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  addDay(){
    if(addingDay){
      return CircularProgressIndicator();
    }
    else{
      return FittedBox(
        child: Text('Add Day',
          style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              //fontSize: 20,
              fontWeight:
              FontWeight
                  .w500),),
      );
    }
  }

  Widget _visit(int index) {
    if (edits[index]) {
      return Column(
        children: List.generate(AllData.doctorsInfo[index]['Day'].length, (i) {
          return DropdownButton<String>(
            value: AllData.doctorsInfo[index]['Day'][i],
            icon: Icon(Icons.arrow_downward),
            onChanged: (String? newValue) async {
              setState(() {
                AllData.doctorsInfo[index]['Day'][i] = newValue!;
              });
              String d = '';

              if (newValue == 'Mon') {
                d = '1';
              } else if (newValue == 'Tue') {
                d = '2';
              } else if (newValue == 'Wed') {
                d = '3';
              } else if (newValue == 'Thu') {
                d = '4';
              } else if (newValue == 'Fri') {
                d = '5';
              } else if (newValue == 'Sat') {
                d = '6';
              } else {
                d = '0';
              }

              final url = Uri.parse(
                  'https://watduwantapi.pythonanywhere.com/api/servicedetailsday/${AllData.doctorsInfo[index]['Service Day ID'][i]}/');
              var response = await http.patch(url,
                  headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                  },
                  body: jsonEncode({
                    'Day': d,
                  }));
              print(response.statusCode);
            },
            items: days.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          );
        }),
      );
    } else {
      return Column(
        children: List.generate(AllData.doctorsInfo[index]['Day'].length, (i) {
          return Text(
            AllData.doctorsInfo[index]['Day'][i],
            style: TextStyle(fontSize: 14, color: Colors.black),
          );
        }),
      );
    }
  }

  Widget _time(int index) {
    if (edits[index]) {
      return Column(
        children: List.generate(AllData.doctorsInfo[index]['Day'].length, (i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenuItem(
                  child: Text(AllData.doctorsInfo[index]['Time'][i])),
              SizedBox(
                width: 10.0.sp,
              ),
              GestureDetector(
                child: Icon(Icons.schedule),
                onTap: () async {
                  final time1 = await showTimePicker(
                    context: context,
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black87,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child ?? Text(""),
                      );
                    },
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  );
                  timing.text = (time1.toString().substring(10, 15) + ":00");

                  setState(() {
                    AllData.doctorsInfo[index]['Time'][i] = timing.text;
                  });

                  final url = Uri.parse(
                      'https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime/${AllData.doctorsInfo[index]['Service Time ID'][i]}/');
                  var response = await http.patch(url,
                      headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        'Time': timing.text,
                      }));
                  print(response.statusCode);
                },
              )
            ],
          );
        }),
      );
    } else {
      return Column(
        children: List.generate(AllData.doctorsInfo[index]['Day'].length, (i) {
          return Text(
              DateFormat.jm().format(DateTime.parse('2021-01-01 ${AllData.doctorsInfo[index]['Time'][i]}')),
            style: TextStyle(fontSize: 14, color: Colors.black),
          );
        }),
      );
    }
  }

  Widget _slots(int index) {
    if (edits[index]) {
      return Column(
        children: List.generate(AllData.doctorsInfo[index]['Day'].length, (i) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Icon(Icons.remove),
                onTap: () async {
                  setState(() {
                    AllData.doctorsInfo[index]['Slots'][i] -= 1;
                  });
                  final url = Uri.parse(
                      'https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime/${AllData.doctorsInfo[index]['Service Time ID'][i]}/');
                  var response = await http.patch(url,
                      headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        'Visit_capacity': AllData.doctorsInfo[index]['Slots']
                            [i],
                      }));
                  print(response.statusCode);
                },
              ),
              SizedBox(
                width: 10.0.sp,
              ),
              DropdownMenuItem(
                  child: Text(
                AllData.doctorsInfo[index]['Slots'][i].toString(),
                style: TextStyle(fontSize: 12.0.sp, color: Colors.black),
              )),
              SizedBox(
                width: 10.0.sp,
              ),
              GestureDetector(
                child: Icon(Icons.add),
                onTap: () async {
                  setState(() {
                    AllData.doctorsInfo[index]['Slots'][i] += 1;
                  });
                  final url = Uri.parse(
                      'https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime/${AllData.doctorsInfo[index]['Service Time ID'][i]}/');
                  var response = await http.patch(url,
                      headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        'Visit_capacity': AllData.doctorsInfo[index]['Slots']
                            [i],
                      }));
                  print(response.statusCode);
                },
              ),
            ],
          );
        }),
      );
    } else {
      return Column(
        children: List.generate(AllData.doctorsInfo[index]['Day'].length, (i) {
          return Text(
            AllData.doctorsInfo[index]['Slots'][i].toString(),
            style: TextStyle(fontSize: 12.0.sp, color: Colors.black),
          );
        }),
      );
    }
  }

  Future<void> _addDay(int index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              title: Text('Add Day'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Text('Day'),
                        title: DropdownButton(
                          value: addDayVisit,
                          icon: Icon(Icons.arrow_downward),
                          onChanged: (String? newVal){
                            setState(() {
                              addDayVisit = newVal!;
                            });
                          },
                          items: addDays.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                    ),
                    ListTile(
                        leading: Text('Time'),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownMenuItem(
                                child: Text(addDayTime)),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                              child: Icon(Icons.schedule),
                              onTap: () async {
                                final time1 = await showTimePicker(
                                  context: context,
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        colorScheme: ColorScheme.dark(
                                          primary: Colors.black,
                                          onPrimary: Colors.white,
                                          surface: Colors.white,
                                          onSurface: Colors.black87,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                      ),
                                      child: child ?? Text(""),
                                    );
                                  },
                                  initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                                );
                                timing.text = (time1.toString().substring(10, 15) + ':00');
                                //timing.text = DateFormat.jm().format(DateTime.parse('2021-01-01 ${time1.toString().substring(10, 15)}'));

                                setState(() {
                                  addDayTime = timing.text;
                                });
                              },
                            )
                          ],
                        ),
                    ),
                    ListTile(
                        leading: Text('Slots'),
                        title: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (String? val){
                                  addDaySlots = val!;
                                  print(addDaySlots);
                                },
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0.sp),
                      child: Text('Note :- Adding a day is irreversible', style: TextStyle(
                          fontFamily: 'Amaranth',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red),),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: addDay(),
                  onPressed: () async {
                    if(addDayVisit != 'Select Date'){
                      setState(() {
                        addingDay = true;
                      });
                      print('Pressed');
                      final url = Uri.parse('https://watduwantapi.pythonanywhere.com/api/services/');
                      String d = '';
                      if (addDayVisit == 'Mon') {
                        d = '1';
                      } else if (addDayVisit == 'Tue') {
                        d = '2';
                      } else if (addDayVisit == 'Wed') {
                        d = '3';
                      } else if (addDayVisit == 'Thu') {
                        d = '4';
                      } else if (addDayVisit == 'Fri') {
                        d = '5';
                      } else if (addDayVisit == 'Sat') {
                        d = '6';
                      } else {
                        d = '7';
                      }
                      var response = await http.post(url,
                          headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'Clinic' : AllData.clinicId,
                            'Doctor' : AllData.doctorsInfo[index]['id'],
                            'Fees' : 500,
                          }));
                      print(response.statusCode);

                      var serviceDetails = await http.get(
                          Uri.parse('https://watduwantapi.pythonanywhere.com/api/services'),
                          headers: {'Accept': 'application/json'});
                      int ServiceID = jsonDecode(serviceDetails.body)[jsonDecode(serviceDetails.body).length-1]['id'];

                      final url1 = Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsday/');
                      var response1 = await http.post(url1,
                          headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'ServiceID' : ServiceID,
                            "Day": d
                          }));
                      print(response1.statusCode);

                      var servicedetailsday = await http.get(
                          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsday'),
                          headers: {'Accept': 'application/json'});
                      int ServiceDetailsDayid = jsonDecode(servicedetailsday.body)[jsonDecode(servicedetailsday.body).length-1]['id'];

                      final url2 = Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime/');
                      var response2 = await http.post(url2,
                          headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            "ServiceDetailsDayID": ServiceDetailsDayid,
                            "Time": addDayTime,
                            'Visit_capacity' : int.parse(addDaySlots),
                          }));
                      print(response2.statusCode);

                      var servicedetails = await http.get(
                          Uri.parse('https://watduwantapi.pythonanywhere.com/api/servicedetailsdaytime'),
                          headers: {'Accept': 'application/json'});
                      int ServiceDetailTimesid = jsonDecode(servicedetails.body)[jsonDecode(servicedetails.body).length-1]['id'];

                      setState(() {
                        /*AllData.doctorsInfo[index]['Day'].add(addDayVisit);
                        AllData.doctorsInfo[index]['Service id'].add(Serviceid);
                        AllData.doctorsInfo[index]['Time'].add(addDayTime);
                        AllData.doctorsInfo[index]['Fees'].add(500);
                        AllData.doctorsInfo[index]['Slots'].add(int.parse(addDaySlots));
                        AllData.doctorsInfo[index]['ServiceID'].add(ServiceDetailsid);*/

                        AllData.doctorsInfo[index]['Service ID'].add(ServiceID);
                        AllData.doctorsInfo[index]['Time'].add(addDayTime);
                        AllData.doctorsInfo[index]['Fees'].add(500);
                        AllData.doctorsInfo[index]['Slots'].add(int.parse(addDaySlots));
                        AllData.doctorsInfo[index]['Service Day ID'].add(ServiceDetailsDayid);
                        AllData.doctorsInfo[index]['Service Time ID'].add(ServiceDetailTimesid);
                        AllData.doctorsInfo[index]['Day'].add(addDayVisit);
                        addingDay = false;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /*updateAppointments() async {
    print('Updating Appointments');
    var appointmentDetails = await http.get(
        Uri.parse('https://watduwantapi.pythonanywhere.com/api/appointments'),
        headers: {'Accept': 'application/json'});

    print('Data Fetch over');

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
    setState(() {
      print('Appointments Updated');
    });
  }*/

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

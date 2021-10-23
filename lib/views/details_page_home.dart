import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/views/theDrawer.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'add_patient.dart';
import 'loadingPage.dart';
import 'package:clipboard/clipboard.dart';

class DetailHome extends StatefulWidget {
  final String userName;
  DetailHome({required this.userName});

  @override
  _DetailHomeState createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  bool visibleHome = true;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();
  String day = DateFormat('EEEE').format(DateTime.now()).toString().substring(0, 3);
  //String day = 'Sun';
  String link = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

  late Timer _timer;

  @override
  void initState() {
    updateAppointments();
    _timer = new Timer.periodic(Duration(seconds: 45),
            (_) => updateAppointments());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle( fontFamily: 'Amaranth', fontSize: 15, color: Colors.black),
            ),
          ),
          SizedBox(width: 10.0,)
        ],
        leading: Builder(
          builder: (context) => Padding(
            padding: EdgeInsets.all(0),
            child: ClipOval(
              child: IconButton(
                icon: Image.asset('assets/Images/logo_oct1.png'),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: ()  async {
          Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingPage(userName: "${widget.userName}",)));
        },
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: !visibleHome,
              child: Center(
                  child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                child: CircularProgressIndicator(),
              )),
            ),
            Visibility(
              visible: !visibleHome,
              child: Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text('Fetching Data'))),
            ),
            Visibility(
              visible: visibleHome,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                AllData.image,
                              ))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          AllData.clinicName,
                          style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        child: Row(
                          children: [
                            Expanded(child: businessOnOrNot()),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text('Share Business' , style: TextStyle(
                                        fontFamily: 'Amaranth',
                                        fontSize: 16,
                                        color: Colors.white),),
                                    onPressed: () => shareBusiness(),
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Name :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                        child: Text(
                          widget.userName,
                          style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Clinic Name :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                        child: Text(
                          AllData.clinicName,
                          style:  TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Email :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                        child: Text(
                          AllData.email,
                          style:  TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Phone :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                        child: Text(
                          AllData.phone,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Address :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                        child: Text(
                          AllData.address,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Opening Hours :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AllData.openingHours,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                      fontSize: 18),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final String time =
                                  await _asyncInputDialog(context);
                              print(time);
                            },
                            icon: Icon(Icons.edit),
                          )
                        ],
                      )),
                    ],
                  ),
                )
                ),
            Visibility(
              visible: visibleHome,
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Visibility(
                visible: visibleHome,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Next Closing Day :',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Amaranth',
                                  fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      SizedBox( width:  10.0,),
                      Expanded(
                        child: Text(
                          AllData.closingDay,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )
                ),
            SizedBox(height: 10),
            Visibility(
              visible: visibleHome,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: Center(
                        child: Text(
                          'Doctors Today',
                          style: TextStyle(
                              fontFamily: 'Amaranth',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Visibility(
              visible: visibleHome,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 2,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                      children: List<Widget>.generate(AllData.doctorsInfo.length,
                              (index) {
                            return Container(
                              child: Row(
                                children: new List<Widget>.generate(
                                    AllData.doctorsInfo[index]['Time'].length,
                                        (timing) {
                                      if (AllData.doctorsInfo[index]['Day'][timing] ==
                                          day) {
                                        return Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 6,
                                                      child: Container(
                                                      width: MediaQuery.of(context).size.width / 3,
                                                      height: MediaQuery.of(context).size.width / 3,
                                                      child: ClipOval(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(
                                                                    fit: BoxFit.cover,
                                                                    image: NetworkImage(
                                                                      AllData.doctorsInfo[index]['Image'],
                                                                    )
                                                                )
                                                            ),
                                                          )
                                                      ),
                                                    ),),
                                                    SizedBox(height: 10.0,),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        AllData.doctorsInfo[index]['Doctor'],
                                                        style: TextStyle(
                                                            fontFamily: 'Roboto',
                                                            fontSize: 16),
                                                      ),),
                                                    Expanded(
                                                      flex:1,
                                                      child: Text(
                                                        DateFormat.jm().format(DateTime.parse('2021-01-01 ${AllData.doctorsInfo[index]['Time'][timing]}')),
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                              fontSize: 16),
                                                    ),),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                      ' ${AllData.doctorsInfo[index]['Appointments'][timing].length} / ${AllData.doctorsInfo[index]['Slots'][timing]}',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                              fontSize: 16),
                                                    ),)
                                                  ],
                                                )
                                        );
                                      }
                                      else{
                                        return SizedBox(height: 0.0,);
                                      }
                                    }),
                              ),
                            );
                          }),
                    ),
              )
            ),
            SizedBox(height: 75.0)
          ],
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
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget businessOnOrNot() {
    if (AllData.status == 'E') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Business On',
            style:TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 16,
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Business Off',
            style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.check_circle_rounded,
            color: Colors.red,
            size: 16,
          )
        ],
      );
    }
  }

  shareBusiness(){
    return showDialog(
        context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text('Share Business'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                        child: Text(link)
                    ),
                    Expanded(
                      flex: 2,
                        child: IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () {
                            //FlutterClipboard.copy(link).then((value) => print('copied'));
                            Clipboard.setData(ClipboardData(text: link));
                          },
                    ))
                  ],
                )

              ],
            ),
          );
    }
    );
  }

  updateAppointments() async{
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

  Future _asyncInputDialog(BuildContext context) async {
    String timings = '';
    TextEditingController openAt = TextEditingController();
    TextEditingController closeAt = TextEditingController();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Enter New Timings',
                style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Open :',
                      style: TextStyle(fontFamily: 'Amaranth',
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DateTimeField(
                        controller: openAt,
                        style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                        format: DateFormat("HH:mm"),
                        onShowPicker: (context, currentValue) async {
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
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          openAt.text =
                          (time1.toString().substring(10, 15) + ":00");
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Close :',
                      style: TextStyle(fontFamily: 'Amaranth',
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DateTimeField(
                        controller: closeAt,
                        style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                        format: DateFormat("HH:mm"),
                        onShowPicker: (context, currentValue) async {
                          final time2 = await showTimePicker(
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
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          closeAt.text =
                          (time2.toString().substring(10, 15) + ":00");
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      timings = '${openAt.text} - ${closeAt.text}';
                      AllData.openingHours = '${DateFormat.jm().format(DateTime.parse('2021-01-01 ${openAt.text}'))} - ${DateFormat.jm().format(DateTime.parse('2021-01-01 ${closeAt.text}'))}';
                      //AllData.openingHours = timings;
                      //print(AllData.openingHours);
                      print(timings);
                      print(AllData.clinicId);
                      final url = Uri.parse(
                          'https://watduwantapi.pythonanywhere.com/api/shops/${AllData.clinicId}/');
                      var response = await http.patch(url,
                          headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json',
                          },
                          body: jsonEncode({
                            'opening_time': openAt.text,
                            'closing_time': closeAt.text
                          }));
                      print(response.statusCode);
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontFamily: 'Amaranth',
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    color: Colors.black,
                    elevation: 0,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              )
            ],
          );
        });
  }
}

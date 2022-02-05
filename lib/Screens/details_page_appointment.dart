import 'dart:async';
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

class DetailAppointment extends StatefulWidget {
  final String userName;
  final String date;
  DetailAppointment({required this.userName, required this.date});

  @override
  _DetailAppointmentState createState() => _DetailAppointmentState();
}

class _DetailAppointmentState extends State<DetailAppointment> {
  String date = DateTime.now().toString().substring(0, 10);
  String day = DateFormat('EEEE').format(DateTime.now()).toString().substring(0, 3);
  List<bool> visible = List.generate(AllData.doctorsInfo.length * 10,
      (index) => false); // Need to figure out an efficient way to do this

  var dateSelected = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController doctorName = TextEditingController();
  /*late Timer _timer;

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
  }*/

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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingPage(userName: "${widget.userName}", firstTime: false,)));
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: 40.w),
              child: Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(fontFamily: 'Roboto',fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 20.0.sp,
                  ),
                  GestureDetector(
                    child: Icon(Icons.calendar_today),
                    onTap: () async {
                      var dateChosen = await showDatePicker(
                        context: context,
                        initialDate: dateSelected,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2023),
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
                      setState(() {
                        dateSelected = dateChosen!;
                        date = dateChosen.toString().substring(0, 10);
                        day = DateFormat('EEEE')
                            .format(dateChosen)
                            .toString()
                            .substring(0, 3);
                        print(day);
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.0.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0.sp, right: 20.0.sp),
              child: MaterialButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  child: Text('Accept All Appointments', style: TextStyle(
                      fontFamily: 'Amaranth',
                      color: Colors.white,
                      fontSize: 14.0.sp),),
                  onPressed: () async{
                    for(int i = 0; i<AllData.doctorsInfo.length; i++){
                      for(int j = 0; j<AllData.doctorsInfo[i]['Time'].length; j++){
                        if (AllData.doctorsInfo[i]['Day'][j] == day) {
                          for(int k = 0; k<AllData.doctorsInfo[i]['Appointments'][j].length; k++){
                            if(AllData.doctorsInfo[i]['Appointments'][j][k]['Status'] == 'P'){
                              final url = Uri.parse(
                                  'https://watduwantapi.pythonanywhere.com/api/appointments/${AllData.doctorsInfo[i]['Appointments'][j][k]['id']}/');
                              var response = await http.patch(url,
                                  headers: {
                                    'Accept': 'application/json',
                                    'Content-Type': 'application/json',
                                  },
                                  body: jsonEncode({
                                    'Status': 'A',
                                  }));
                              print(response.statusCode);
                              AllData.doctorsInfo[i]['Appointments'][j][k]['Status'] = 'A';
                            }
                          }
                        }
                      }
                    }
                    setState(() {
                      final snackBar = SnackBar(
                        content:
                        Text('All Pending Appointments of the selected day have been Accepted', style: TextStyle(fontFamily: 'Roboto',color: Colors.white, fontSize: 12.0.sp),),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
              child: ListView.builder(
                  itemCount: AllData.doctorsInfo.length,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0.sp),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(color: Colors.white, offset: Offset(0.0, 0.1))
                      ]),
                      child: Column(
                          children: new List<Widget>.generate(
                              AllData.doctorsInfo[index]['Time'].length,
                              (timing) {
                        if (AllData.doctorsInfo[index]['Day'][timing] == day) {
                          return Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      width: 33.w,
                                      height: 33.w,
                                      decoration:
                                      BoxDecoration(color: Colors.grey[300]),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 15.0.sp,),
                                          Container(
                                            width: 18.w,
                                            height: 18.w,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: CachedNetworkImageProvider(
                                                      AllData.doctorsInfo[index]
                                                      ['Image'],
                                                    ))),
                                          ),
                                          SizedBox(height: 5.0.sp,),
                                          FittedBox(
                                            child: Text(
                                              AllData.doctorsInfo[index]['Doctor'],
                                              style: TextStyle(
                                                  fontFamily: 'Amaranth',
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          SizedBox(height: 10.0.sp,)
                                        ],
                                      ),
                                    )
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 33.w,
                                      height: 33.w,
                                      decoration:
                                          BoxDecoration(color: Colors.grey[300]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Timing',
                                            style: TextStyle(
                                              fontFamily: 'Amaranth',
                                                    fontSize: 14.0.sp,
                                                    fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0.sp,
                                          ),
                                          Text(
                                            DateFormat.jm().format(DateTime.parse('2021-01-01 ${AllData.doctorsInfo[index]['Time'][timing]}')),
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                                    fontSize: 12.0.sp,
                                                    fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 33.w,
                                      height: 33.w,
                                      decoration:
                                          BoxDecoration(color: Colors.grey[300]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Bookings',
                                            style: TextStyle(
                                                    fontSize: 14.0.sp,
                                                    fontFamily: 'Amaranth',
                                                    fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0.sp,
                                          ),
                                          Text(
                                            ' ${AllData.doctorsInfo[index]['Appointments'][timing].length} / ${AllData.doctorsInfo[index]['Slots'][timing]}',
                                            style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      if (visible[
                                          int.parse('$index' + '$timing')]) {
                                        setState(() {
                                          visible[int.parse(
                                              '$index' + '$timing')] = false;
                                        });
                                      } else {
                                        setState(() {
                                          visible[int.parse(
                                              '$index' + '$timing')] = true;
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'View Patients',
                                          style: TextStyle(
                                            fontFamily: 'Amaranth',
                                                  fontSize: 10.0.sp,
                                                  fontWeight: FontWeight.w700,
                                                  ),
                                        ),
                                        visible[int.parse('$index' + '$timing')]
                                            ? Icon(Icons.arrow_drop_up)
                                            : Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                  visible:
                                      visible[int.parse('$index' + '$timing')],
                                  child: SingleChildScrollView(
                                      physics: ScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: appointmentsAvailableOrNot(
                                                index, timing),
                                            color: Colors.grey[300],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Column(
                                            children: new List<Widget>.generate(
                                                AllData
                                                    .doctorsInfo[index]
                                                        ['Appointments'][timing]
                                                    .length, (j) {
                                              return Container(
                                                  color: j.isEven
                                                      ? Colors.white
                                                      : Colors.grey[200],
                                                  child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Text(
                                                            AllData.doctorsInfo[
                                                                    index][
                                                                    'Appointments']
                                                                    [timing][j]
                                                                    ['Rank']
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontFamily: 'Roboto',
                                                                    fontSize: 11.0.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                              AllData.doctorsInfo[
                                                                              index]
                                                                          [
                                                                          'Appointments']
                                                                      [timing][j]
                                                                  ['Patient'],
                                                              style: TextStyle(
                                                                  fontFamily: 'Roboto',
                                                                      fontSize:
                                                                          11.0.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            )),
                                                        Expanded(
                                                          child: Text(
                                                            AllData.doctorsInfo[index]['Appointments']
                                                                    [timing][j]
                                                                    ['Contact']
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontFamily: 'Roboto',
                                                                    fontSize: 11.0.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: acceptOrDecline(
                                                                    index,
                                                                    timing,
                                                                    j)),
                                                      ],
                                                    ),
                                                  );
                                            }),
                                          ),
                                          SizedBox(height: 10.0.sp,),
                                          Visibility(
                                            visible: AllData.doctorsInfo[index]['Appointments'][timing].length != 0,
                                              child: MaterialButton(
                                            onPressed: () async{
                                              for(int k = 0; k<AllData.doctorsInfo[index]['Appointments'][timing].length; k++){
                                                if(AllData.doctorsInfo[index]['Appointments'][timing][k]['Status'] == 'P'){
                                                  final url = Uri.parse(
                                                      'https://watduwantapi.pythonanywhere.com/api/appointments/${AllData.doctorsInfo[index]['Appointments'][timing][k]['id']}/');
                                                  var response = await http.patch(url,
                                                      headers: {
                                                        'Accept': 'application/json',
                                                        'Content-Type': 'application/json',
                                                      },
                                                      body: jsonEncode({
                                                        'Status': 'A',
                                                      }));
                                                  print(response.statusCode);
                                                  AllData.doctorsInfo[index]['Appointments'][timing][k]['Status'] = 'A';
                                                }
                                              }
                                              setState(() {
                                                final snackBar = SnackBar(
                                                  content:
                                                  Text('All Pending Appointments have been Accepted', style: TextStyle(fontFamily: 'Roboto',color: Colors.white, fontSize: 14.0),),
                                                  behavior: SnackBarBehavior.floating,
                                                  backgroundColor: Colors.green,);
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              });
                                            },
                                            height: 20.0.sp,
                                            color: Colors.grey[400],
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)
                                                )),
                                            child: FittedBox(
                                              child:  Text('Accept All Appointments',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500),),
                                              fit: BoxFit.scaleDown,
                                            )
                                          ))
                                        ],
                                      )))
                            ],
                          );
                        } else {
                          return SizedBox(
                            width: 2.w,
                          );
                        }
                      })),
                    );
                  }),
            ),
            SizedBox(
              height: 10.h,
            ),
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

  acceptOrDecline(int index, int timing, int j) {
    String status = AllData.doctorsInfo[index]['Appointments'][timing][j]['Status'];
    if (status == 'A') {
      return MaterialButton(
          onPressed: (){
            status = 'A';
          },
        height: 30.0.sp,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        color: Colors.black,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Accepted',
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.white,
                //fontSize: 20,
                fontWeight:
                FontWeight
                    .w500),),

        )

      );
    } else if (status == 'P') {
      return MaterialButton(
          onPressed: () async {
            print(AllData.doctorsInfo[index]['Appointments'][timing][j]);
            print(AllData.doctorsInfo[index]['Appointments'][timing][j]
                ['Patient']);

            final url = Uri.parse(
                'https://watduwantapi.pythonanywhere.com/api/appointments/${AllData.doctorsInfo[index]['Appointments'][timing][j]['id']}/');
            var response = await http.patch(url,
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode({
                  'Status': 'A',
                }));
            print(response.statusCode);
            setState(() {
              AllData.doctorsInfo[index]['Appointments'][timing][j]['Status'] =
                  'A';
            });
          },
        height: 30.0.sp,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)
        )),
        color: Colors.grey[400],
          child: FittedBox(
            child: Text('Pending',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  //fontSize: 11,
                  fontWeight:
                  FontWeight
                      .w500),),
            fit: BoxFit.scaleDown,
          ));
    } else {
      return MaterialButton(
          onPressed: (){
            status = status;
          },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)
        )),
        child:FittedBox(
          child:  Text('Cancelled', style: TextStyle(
              fontFamily: 'Roboto', color: Colors.black, fontSize: 11, fontWeight: FontWeight.w500
          ),),
          fit: BoxFit.scaleDown,
        ),
        color: Colors.grey[400],
      );
    }
  }

  appointmentsAvailableOrNot(int index, int timing) {
    if (AllData.doctorsInfo[index]['Appointments'][timing].length != 0) {
      return Padding(
        padding: EdgeInsets.only(top: 15.0.sp, bottom: 15.0.sp),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Rank',
                style: TextStyle(fontFamily: 'Amaranth',fontSize: 11.0.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Text(
                'Name',
                style:
                    TextStyle(fontFamily: 'Amaranth', fontSize: 11.0.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Text(
                'Contact',
                style:
                    TextStyle(fontFamily: 'Amaranth',fontSize: 11.0.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Text(
                'Status',
                style:
                    TextStyle(fontFamily: 'Amaranth',fontSize: 11.0.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding:
            EdgeInsets.only(top: 10.0.sp, bottom: 10.0.sp, left: 7.0.sp, right: 7.0.sp),
        child: Text('No Appointments', style: TextStyle(fontFamily: 'Amaranth'),),
      );
    }
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

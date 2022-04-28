import 'package:booking_system/Services/GetAppointments.dart';
import 'package:booking_system/data/UpdateAppointments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/Screens/theDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'addPatient.dart';
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
  String day =
      DateFormat('EEEE').format(DateTime.now()).toString().substring(0, 3);
  //List<bool> visible = List.generate(AllData.home.doctors!.length * 10,
  //(index) => false); // Need to figure out an efficient way to do this

  var dateSelected = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController doctorName = TextEditingController();
  bool _loading = true;
  List<int> bookings = [];

  callAppointmentsApi() async {
    setState(() {
      _loading = true;
    });
    await AllAppointments.getAllAppointments().then((value) {
      if (value != null) {
        AllData.appointments = value;
        bookings = [];
        for (var i in AllData.appointments) {
          print(i[0].doctor!.name);
          int a = 0;
          for (var j in i) {
            print(j.day!);
            if (j.day! == date) {
              a += 1;
            }
          }
          bookings.add(a);
          print(bookings);
        }
        _loading = false;
        print(value.length);
        print('Done!');
        setState(() {
          _loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    callAppointmentsApi();
  }
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
              style: TextStyle(
                  fontFamily: 'Amaranth',
                  fontSize: 12.0.sp,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            width: 10.0.sp,
          )
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
        onRefresh: () async {
          //Navigator.of(context).pop();
          updateAppointments();
        },
        child: _loading ? Center(child: CircularProgressIndicator(),) : ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w500),
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
                      setState(() {
                        dateSelected = dateChosen!;
                        date = dateChosen.toString().substring(0, 10);
                        print(date);
                        day = DateFormat('EEEE')
                            .format(dateChosen)
                            .toString()
                            .substring(0, 3);
                        print(day);
                        bookings = [];
                        for (var i in AllData.appointments) {
                          print(i[0].doctor!.name);
                          int a = 0;
                          for (var j in i) {
                            print(j.day!);
                            if (j.day == date) {
                              a += 1;
                            }
                          }
                          bookings.add(a);
                          print(bookings);
                        }
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                  child: Text(
                    'Accept All Appointments',
                    style: TextStyle(
                        fontFamily: 'Amaranth',
                        color: Colors.white,
                        fontSize: 14.0.sp),
                  ),
                  onPressed: () async {
                    // for(int i = 0; i<AllData.doctorsInfo.length; i++){
                    //   for(int j = 0; j<AllData.doctorsInfo[i]['Time'].length; j++){
                    //     if (AllData.doctorsInfo[i]['Day'][j] == day) {
                    //       for(int k = 0; k<AllData.doctorsInfo[i]['Appointments'][j].length; k++){
                    //         if(AllData.doctorsInfo[i]['Appointments'][j][k]['Status'] == 'P'){
                    //           final url = Uri.parse(
                    //               'https://watduwantapi.pythonanywhere.com/api/appointments/${AllData.doctorsInfo[i]['Appointments'][j][k]['id']}/');
                    //           var response = await http.patch(url,
                    //               headers: {
                    //                 'Accept': 'application/json',
                    //                 'Content-Type': 'application/json',
                    //               },
                    //               body: jsonEncode({
                    //                 'Status': 'A',
                    //               }));
                    //           print(response.statusCode);
                    //           AllData.doctorsInfo[i]['Appointments'][j][k]['Status'] = 'A';
                    //         }
                    //       }
                    //     }
                    //   }
                    // }
                    // setState(() {
                    //   final snackBar = SnackBar(
                    //     content:
                    //     Text('All Pending Appointments of the selected day have been Accepted', style: TextStyle(fontFamily: 'Roboto',color: Colors.white, fontSize: 12.0.sp),),
                    //     behavior: SnackBarBehavior.floating,
                    //     backgroundColor: Colors.green,);
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // });
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.sp),
              child: ListView.builder(
                itemCount: AllData.appointments.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (bookings[index] != 0) {
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0.sp),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Colors.white, offset: Offset(0.0, 0.1))
                        ]),
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                        width: 33.w,
                                        height: 33.w,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300]),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15.0.sp,
                                            ),
                                            Container(
                                              width: 18.w,
                                              height: 18.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        'https://watduwantapi.pythonanywhere.com${AllData.appointments[index][0].doctor!.image!}',
                                                      ))),
                                            ),
                                            SizedBox(
                                              height: 5.0.sp,
                                            ),
                                            FittedBox(
                                              child: Text(
                                                AllData.appointments[index][0]
                                                    .doctor!.name!,
                                                style: TextStyle(
                                                    fontFamily: 'Amaranth',
                                                    fontSize: 12.0.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              fit: BoxFit.scaleDown,
                                            ),
                                            SizedBox(
                                              height: 10.0.sp,
                                            )
                                          ],
                                        ),
                                      )),
                                      Expanded(
                                        child: Container(
                                          width: 33.w,
                                          height: 33.w,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10.0.sp,
                                              ),
                                              Text(
                                                DateFormat.jm().format(
                                                    DateTime.parse(
                                                        '2021-01-01 ${AllData.appointments[index][0].timing!.time!}')),
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12.0.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: 33.w,
                                          height: 33.w,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300]),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 10.0.sp,
                                              ),
                                              Text(
                                                ' ${bookings[index]} / ${AllData.appointments[index][0].timing!.visitCapacity!}',
                                                style: TextStyle(
                                                    fontSize: 12.0.sp,
                                                    fontFamily: 'Roboto',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                              child: Padding(
                                padding: EdgeInsets.only(top: 15.0.sp, bottom: 15.0.sp),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Rank',
                                        style: TextStyle(
                                            fontFamily: 'Amaranth',
                                            fontSize: 11.0.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Name',
                                        style: TextStyle(
                                            fontFamily: 'Amaranth',
                                            fontSize: 11.0.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Contact',
                                        style: TextStyle(
                                            fontFamily: 'Amaranth',
                                            fontSize: 11.0.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                            fontFamily: 'Amaranth',
                                            fontSize: 11.0.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.grey[300],
                            ),
                            SizedBox(
                              height: 15.0.sp,
                            ),
                            Container(
                              child: Column(
                                children: List.generate(
                                    AllData.appointments[index].length, (i) {
                                  if (AllData.appointments[index][i].day! ==
                                      date) {
                                    return SingleChildScrollView(
                                        physics: ScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Container(
                                              color: i.isEven
                                                  ? Colors.white
                                                  : Colors.grey[200],
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.0.sp),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        AllData
                                                            .appointments[index]
                                                                [i]
                                                            .rank
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 11.0.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          AllData
                                                              .appointments[
                                                                  index][i]
                                                              .patientName!,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 11.0.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        AllData
                                                            .appointments[index]
                                                                [i]
                                                            .phone
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 11.0.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 2,
                                                        child: acceptOrDecline(
                                                            index, i)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0.sp,
                                            ),
                                            /*Visibility(
                                            visible: AllData.appointments[index].length != 0,
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
                                            ))*/
                                          ],
                                        ));
                                  } else {
                                    return Container();
                                  }
                                }),
                              ),
                            )
                          ],
                        ));
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0.sp),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(color: Colors.white, offset: Offset(0.0, 0.1))
                      ]),
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      width: 33.w,
                                      height: 33.w,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300]),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15.0.sp,
                                          ),
                                          Container(
                                            width: 18.w,
                                            height: 18.w,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      'https://watduwantapi.pythonanywhere.com${AllData.appointments[index][0].doctor!.image!}',
                                                    ))),
                                          ),
                                          SizedBox(
                                            height: 5.0.sp,
                                          ),
                                          FittedBox(
                                            child: Text(
                                              AllData.appointments[index][0]
                                                  .doctor!.name!,
                                              style: TextStyle(
                                                  fontFamily: 'Amaranth',
                                                  fontSize: 12.0.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          SizedBox(
                                            height: 10.0.sp,
                                          )
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                      child: Container(
                                        width: 33.w,
                                        height: 33.w,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300]),
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
                                              DateFormat.jm().format(DateTime.parse(
                                                  '2021-01-01 ${AllData.appointments[index][0].timing!.time!}')),
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
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300]),
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
                                              ' ${bookings[index]} / ${AllData.appointments[index][0].timing!.visitCapacity!}',
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0.sp,
                                bottom: 10.0.sp,
                                left: 7.0.sp,
                                right: 7.0.sp),
                            child: Text(
                              'No Appointments',
                              style: TextStyle(fontFamily: 'Amaranth', fontSize: 14.0.sp),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
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

  acceptOrDecline(int index, int i) {
    String? status = AllData.appointments[index][i].status;
    if (status == 'A') {
      return MaterialButton(
          onPressed: () {
            status = 'A';
          },
          height: 30.0.sp,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.black,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Accepted',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  //fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ));
    } else if (status == 'P') {
      return MaterialButton(
          onPressed: () async {
            print(AllData.appointments[index][i].patientName);
            /*final url = Uri.parse(
                'https://watduwantapi.pythonanywhere.com/api/appointments/${AllData.doctorsInfo[index]['Appointments'][timing][j]['id']}/');
            var response = await http.patch(url,
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode({
                  'Status': 'A',
                }));
            print(response.statusCode);*/
            setState(() {
              AllData.appointments[index][i].status = 'A';
            });
          },
          height: 30.0.sp,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.grey[400],
          child: FittedBox(
            child: Text(
              'Pending',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  //fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
            fit: BoxFit.scaleDown,
          ));
    } else {
      return MaterialButton(
        onPressed: () {
          status = status;
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: FittedBox(
          child: Text(
            'Cancelled',
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w500),
          ),
          fit: BoxFit.scaleDown,
        ),
        color: Colors.grey[400],
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

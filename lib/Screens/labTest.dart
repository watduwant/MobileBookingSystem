import 'dart:convert';
import 'package:booking_system/Screens/assignLabTest.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/Screens/theDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'addPatient.dart';
import 'loadingPage.dart';

class LabTests extends StatefulWidget {
  final String userName;
  LabTests({required this.userName});

  @override
  _LabTestsState createState() => _LabTestsState();
}

class _LabTestsState extends State<LabTests> {
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
      body: SingleChildScrollView(
        child: Container(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  height: 7.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: TextStyle(
                      fontFamily: 'Amaranth',
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(10.0.w)),
                    ),
                    tabs: [Text('Assign'), Text('Report')],
                  ),
                ),
                Container(
                  height: 80.h,
                  child: TabBarView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 2.h),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0.sp),
                                  color: Colors.grey.withOpacity(0.4)),
                              margin: EdgeInsets.only(bottom: 10.0.sp),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text('Name',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text('Tom Holland',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text('Contact',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text('9878809623',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text('Day',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text('23rd Feb',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text('Location',
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      '21, Marine Drive, Kolkata',
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 12.0.sp,
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: MaterialButton(
                                        padding: EdgeInsets.only(
                                            top: 5.0.sp,
                                            bottom: 5.0.sp,
                                            left: 10.0.sp,
                                            right: 10.0.sp),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => AssignLabTest(
                                                    userName: widget.userName,
                                                  )));
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0.sp)),
                                        color: Colors.black,
                                        child: Text(
                                          'Assign',
                                          style: TextStyle(
                                              fontSize: 12.0.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 5.w),
                        child: ListView.builder(
                          itemCount: 18,
                          itemBuilder: (context, index){
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0.sp),
                                  color: Colors.grey.withOpacity(0.4)),
                              margin: EdgeInsets.only(bottom: 10.0.sp),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text('Collected : 11th Feb', style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10.0.sp,
                                              color: Colors.black),),
                                        ),
                                        Container(
                                          child: Text('Status : Assigned', style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10.0.sp,
                                              color: Colors.black),),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.sp,
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text('Name',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12.0.sp,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.black)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text('Rohan',
                                                    textAlign:
                                                    TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12.0.sp,
                                                        color: Colors.black)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text('Test',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12.0.sp,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.black)),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text('High Density Lipoprotein (HDL)',
                                                    textAlign:
                                                    TextAlign.start,
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 12.0.sp,
                                                        color: Colors.black)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0.sp,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        MaterialButton(
                                          onPressed: (){

                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0.sp),
                                          ),
                                          child: Text('Upload Report', style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 8.0.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),),
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

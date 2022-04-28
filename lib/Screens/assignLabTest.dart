import 'dart:convert';
import 'package:booking_system/Utils/Symbols.dart';
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

class AssignLabTest extends StatefulWidget {
  final String userName;
  AssignLabTest({required this.userName});

  @override
  _AssignLabTestState createState() => _AssignLabTestState();
}

class _AssignLabTestState extends State<AssignLabTest> {
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.sp),
                    color: Colors.grey.withOpacity(0.4)),
                margin: EdgeInsets.only(top: 1.h, left: 5.w, right: 5.w, bottom: 10.0.sp),
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
                            child: Text('Tests', style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 10.0.sp,
                                color: Colors.black),),
                          ),
                          Container(
                            child: Text('Costs', style: TextStyle(
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
                    Column(
                      children: List.generate(2, (index) {
                        return Container(
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text('Fasting Blood Sugar (FBS)',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0.sp,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.black)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('x1',
                                      textAlign:
                                      TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0.sp,
                                          color: Colors.black)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text('${ConstantSymbols.rssymbol} 750',
                                      textAlign:
                                      TextAlign.end,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12.0.sp,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10.0.sp,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Container(
                            child: Text('Total : ${ConstantSymbols.rssymbol} 1650', style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12.0.sp,
                                color: Colors.black),),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 5.w),
                child: Text('Phelobotomist : ', style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  children: List.generate(4, (index) {
                    return ListTile(
                      leading: Container(
                        height: 50.0.sp,
                        width: 50.0.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red
                        ),
                      ),
                      title: Text('Ryan Gosling', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12.0.sp,
                          color: Colors.black)),
                      subtitle: Text('8079924321', style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 10.0.sp,
                          color: Colors.grey)),
                      trailing: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.sp),
                        ),
                        color: Colors.black,
                        onPressed: (){

                        },
                        child: Text('Appoint', style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.white),),
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
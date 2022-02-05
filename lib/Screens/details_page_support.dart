import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/Screens/theDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:sizer/sizer.dart';

class DetailSupport extends StatefulWidget {
  final String userName;
  DetailSupport({required this.userName});

  @override
  _DetailSupportState createState() => _DetailSupportState();
}

class _DetailSupportState extends State<DetailSupport> {
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();
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
          SizedBox(width: 10.0.sp)
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
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  'Mail Us',
                  style: TextStyle(
                      fontFamily: 'Amaranth',
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20.0.sp, 10.0.sp, 20.0.sp, 10.0.sp),
              padding: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 10.0.sp),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(0.1, 0.1))
              ]),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: subject,
                    style: TextStyle(fontFamily: 'Roboto',fontSize: 14.0.sp),
                    decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Subject',
                        hintStyle: TextStyle(fontFamily: 'Roboto',fontSize: 13.0.sp),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10.0.sp)),
                  ),
                  SizedBox(
                    height: 10.0.sp,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    minLines: 5,
                    maxLines: 10,
                    controller: body,
                    style: TextStyle(fontFamily: 'Roboto',fontSize: 14.0.sp),
                    decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Write Your Feedback/Query...',
                        hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15, fontStyle: FontStyle.italic),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5.0.sp, horizontal: 10.0.sp)),
                  ),
                  SizedBox(
                    height: 10.0.sp,
                  ),
                  Container(
                    height: 40.0.sp,
                    width: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0.sp),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(5.0.sp),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Send',
                          style: TextStyle(
                              fontFamily: 'Amaranth',
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              padding: EdgeInsets.all(5.0.sp),
              child: Center(
                child: Text(
                  'Call Us',
                  style: TextStyle(
                      fontFamily: 'Amaranth',
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20.0.sp, 10.0.sp, 20.0.sp, 10.0.sp),
              padding: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 10.0.sp),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(0.1, 0.1))
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AllData.phone,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0.sp)
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              AllData.phone);
                        },
                        icon: Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

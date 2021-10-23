import 'package:booking_system/data/dataFetcher.dart';
import 'package:booking_system/views/theDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black, offset: Offset(0.1, 0.1))
              ]),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: subject,
                    style: TextStyle(fontFamily: 'Roboto',fontSize: 17),
                    decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Subject',
                        hintStyle: TextStyle(fontFamily: 'Roboto',fontSize: 15),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    minLines: 5,
                    maxLines: 10,
                    controller: body,
                    style: TextStyle(fontFamily: 'Roboto',fontSize: 17),
                    decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Write Your Feedback/Query...',
                        hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15, fontStyle: FontStyle.italic),
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black,
                    ),
                    padding: EdgeInsets.all(5),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Send',
                          style: TextStyle(
                              fontFamily: 'Amaranth',
                                  fontSize: 18,
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
              padding: EdgeInsets.all(5),
              child: Center(
                child: Text(
                  'Call Us',
                  style: TextStyle(
                      fontFamily: 'Amaranth',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)
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

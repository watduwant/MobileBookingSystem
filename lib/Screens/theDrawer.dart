import 'package:booking_system/Local%20DB/localdb.dart';
import 'package:booking_system/Screens/doctors.dart';
import 'package:booking_system/Screens/announcement.dart';
import 'package:booking_system/Screens/appointment.dart';
import 'package:booking_system/Screens/home.dart';
import 'package:booking_system/Screens/support.dart';
import 'package:booking_system/Screens/labTest.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class TheDrawer extends StatefulWidget {
  final String userName;
  TheDrawer({required this.userName});

  @override
  TheDrawerState createState() => TheDrawerState();
}

class TheDrawerState extends State<TheDrawer>{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black
              ),
              child: Image.asset('assets/Images/logo_oct_black1.jpg'),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailHome(userName: widget.userName)));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.home,),
                    SizedBox(width: 10,),
                    Text('Home',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailAppointment(userName: widget.userName,date: DateTime.now().toString().substring(0,10),)));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10,),
                    Text('Appointments',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailDoctor(userName: widget.userName)));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.healing),
                    SizedBox(width: 10,),
                    Text('View & Edit Doctors',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context)=>LabTests(userName: widget.userName)));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.broken_image),
                    SizedBox(width: 10,),
                    Text('Lab Reports',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailAnnouncement(userName: widget.userName)));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.announcement),
                    SizedBox(width: 10,),
                    Text('Announcement',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailSupport(userName: widget.userName)));
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.support),
                    SizedBox(width: 10,),
                    Text('Support',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26),
            ListTile(
              onTap: () async {
                //Navigator.pop(context);
                //.push(context,MaterialPageRoute(builder: (context)=>Home()));
                await LocalDb.logout(context);
              },
              title: Row(
                  children: <Widget>[
                    Icon(Icons.logout),
                    SizedBox(width: 10,),
                    Text('Logout',style: TextStyle(fontFamily: 'Amaranth',fontWeight: FontWeight.w500,fontSize: 20),)
                  ]
              ),
            ),
            Divider(color: Colors.black26,),
            SizedBox(height: 55,),
            ListTile(
                title: Center(child: Text('Copyright ©Whatduwant. All Rights Reserved.', style: TextStyle(fontFamily: 'Roboto',fontSize: 14,color: Colors.black26),))
            ),
          ],
        ),
      ),
    );
  }
  
}
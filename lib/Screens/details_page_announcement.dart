import 'package:booking_system/Screens/theDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:booking_system/data/dataFetcher.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailAnnouncement extends StatefulWidget {
  final String userName;
  DetailAnnouncement({required this.userName});

  @override
  _DetailAnnouncementState createState() => _DetailAnnouncementState();
}

class _DetailAnnouncementState extends State<DetailAnnouncement> {
  TextEditingController doctor = TextEditingController();
  TextEditingController slot = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();
  String chosenDay =
      DateFormat('EEEE').format(DateTime.now()).toString().substring(0, 3);

  var setDate = DateTime.now();

  List<String> _reasons = [
    "I am sick",
    "Vacation",
    "Late to work",
  ];

  String _selectedReason = "I am sick";
  List<Map> doctorsAndSlots = [];
  bool reasonTime = false;

  @override
  void initState() {
    createCheckboxes();
    super.initState();
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: 100.w,
                color: Colors.black,
                padding: EdgeInsets.all(5.0.sp),
                child: Center(
                  child: Text(
                    'Announcement',
                    style: GoogleFonts.prompt(
                        textStyle: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0.sp, 10.0.sp, 20.0.sp, 10.0.sp),
                padding: EdgeInsets.symmetric(horizontal: 10.0.sp, vertical: 10.0.sp),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: DropdownMenuItem(
                          child: Center(
                            child: Text(
                              setDate.toString().substring(0, 10),
                              style: TextStyle(
                                  fontFamily: 'Amaranth',
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),),
                      onTap: () async {
                        var dateChosen = await showDatePicker(
                          context: context,
                          initialDate: setDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2022),
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
                        chosenDay = DateFormat('EEEE')
                            .format(dateChosen)
                            .toString()
                            .substring(0, 3);
                        setState(() {
                          reasonTime = false;
                          createCheckboxes();
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: doctorsAndSlots.map((e) {
                        return CheckboxListTile(
                          checkColor: Colors.white,
                          selectedTileColor: Colors.black,
                          activeColor: Colors.black,
                          title: Text(e['Info'], style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.0.sp,),),
                            value: e['isChecked'],
                            onChanged: (val){
                            setState(() {
                              if(e['Info'] != 'No Doctor Available'){
                                e['isChecked'] = val;
                                reasonTime = false;

                                for(dynamic i in doctorsAndSlots){
                                  if(i['isChecked'] == true){
                                    reasonTime = true;
                                  }
                                }
                              }
                            });
                            }
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Visibility(
                      visible: reasonTime,
                      child: DropdownButtonFormField(
                          onChanged: (value) =>
                              _selectedReason = value.toString(),
                          value: _selectedReason,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0.0.sp, horizontal: 10.0.sp)),
                          items: _reasons
                              .map<DropdownMenuItem<String>>((String val) {
                            return DropdownMenuItem<String>(
                                value: val, child: Text(val));
                          }).toList()),
                    ),
                    SizedBox(
                      height: 20.0.sp,
                    ),
                    Container(
                      height: 40.0.sp,
                      width: 100.0.sp,
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
                            style: GoogleFonts.prompt(
                                textStyle: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createCheckboxes(){
    doctorsAndSlots = [];
    for (int i = 0; i < AllData.doctorsInfo.length; i++) {
      for (int j = 0; j < AllData.doctorsInfo[i]['Day'].length; j++) {
        if (AllData.doctorsInfo[i]['Day'][j] == chosenDay) {
          doctorsAndSlots.add({
            'Info' : '${AllData.doctorsInfo[i]['Doctor']} ${DateFormat.jm().format(DateTime.parse('2021-01-01 ${AllData.doctorsInfo[i]['Time'][j]}'))}',
            'isChecked' : false,
          });
        }
      }
    }

    if(doctorsAndSlots.length == 0){
      doctorsAndSlots.add({
        'Info' : 'No Doctor Available',
        'isChecked' : false,
      });
    }
  }
}

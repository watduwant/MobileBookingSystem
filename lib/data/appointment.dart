import 'doctor_list.dart';

Map pat1 = {
  'rank': '01',
  'name': 'Kiran Kher',
  'contact': '9876543210',
  'status': false
};
Map pat2 = {
  'rank': '02',
  'name': 'Aniket Som',
  'contact': '9876543210',
  'status': false
};
Map pat3 = {
  'rank': '03',
  'name': 'Swattick Dutta',
  'contact': '9876543210',
  'status': false
};
List<Map> pat = [
  pat1,
  pat2,
  pat3,
  pat1,
  pat2,
  pat3,
  pat1,
  pat2,
  pat3,
  pat1,
  pat2,
  pat3
];
Map date1dat1 = {
  'Doctor': doc1,
  'Timings': '15.00 - 18.00',
  'booking': '12',
  'capacity': '15',
  'patient data': pat
};
Map date1dat2 = {
  'Doctor': doc2,
  'Timings': '15.00 - 18.00',
  'booking': '12',
  'capacity': '15',
  'patient data': pat
};
Map date1dat3 = {
  'Doctor': doc3,
  'Timings': '15.00 - 18.00',
  'booking': '12',
  'capacity': '15',
  'patient data': pat
};
Map date2dat1 = {
  'Doctor': doc1,
  'Timings': '15.00 - 18.00',
  'booking': '12',
  'capacity': '15',
  'patient data': pat
};
Map date2dat2 = {
  'Doctor': doc2,
  'Timings': '15.00 - 18.00',
  'booking': '12',
  'capacity': '15',
  'patient data': pat
};
Map date2dat3 = {
  'Doctor': doc3,
  'Timings': '15.00 - 18.00',
  'booking': '12',
  'capacity': '15',
  'patient data': pat
};

List<Map> dat1 = [date1dat1, date1dat2, date1dat3];
List<Map> dat2 = [date2dat1, date2dat2, date2dat3];

Map appo1 = {
  DateTime.now().toString().substring(0, 10): dat1,
  '2021-07-19': dat2
};

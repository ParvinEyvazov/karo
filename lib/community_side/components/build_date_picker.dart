/*
DAHA SONRA WIDGET-LARA AYIRARKEN ISTIFADE EDILECEK

ISTIFADESI COMMUNITY_ADD_EVENT.DART FILE-I ICINDEDI
*/



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class BuildDatePicker extends StatefulWidget {
//   DateTime selectedDate;
//   BuildDatePicker(this.selectedDate);

//   @override
//   _BuildDatePickerState createState() => _BuildDatePickerState();
// }

// class _BuildDatePickerState extends State<BuildDatePicker> {
//   final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm');
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //widget.selectedDate = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(dateFormat.format(widget.selectedDate)),
//         RaisedButton(
//           child: Text('Choose new date time'),
//           onPressed: () async {
//             final selectedDate = await _selectDateTime(context);
//             if (selectedDate == null) return;

//             print(selectedDate);

//             final selectedTime = await _selectTime(context);
//             if (selectedTime == null) return;
//             print(selectedTime);

//             setState(() {
//               widget.selectedDate = DateTime(
//                 selectedDate.year,
//                 selectedDate.month,
//                 selectedDate.day,
//                 selectedTime.hour,
//                 selectedTime.minute,
//               );

//               print("setState ici w- : ${selectedDate.toString()}");
//               print("setState ici w+ : ${widget.selectedDate.toString()}");
//             });
//             print(widget.selectedDate);
//           },
//         ),
//       ],
//     );
//   }

//   Future<TimeOfDay> _selectTime(BuildContext context) {
//     final now = DateTime.now();

//     return showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
//     );
//   }

//   Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
//         context: context,
//         initialDate: DateTime.now().add(Duration(seconds: 1)),
//         firstDate: DateTime.now(),
//         lastDate: DateTime(2100),
//       );
// }

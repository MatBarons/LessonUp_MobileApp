import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:progetto_ium/Common/Model/LessonModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';

class BuyPage extends StatefulWidget {

  String s;

  BuyPage(this.s,{super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {

  DateTime _focusedDay = DateTime(2023,4,20);
  DateTime? _selectedDay=DateTime(2023,4,20);
  CalendarFormat _calendarFormat = CalendarFormat.month;

  late List<Lecture> tList; //lista di 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 30),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2021, 01, 01),
            lastDay: DateTime.utc(2023, 12, 31),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            onFormatChanged: (newFormat) {
              setState(() {
                _calendarFormat = newFormat;
              });
            },
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey,thickness: 1),
          const SizedBox(height: 15),
          FutureBuilder(
            future: ApiLecture().getLecturesBySubjectAndStatusAndDate(widget.s,"${_selectedDay!.year}-${_selectedDay!.month}-${_selectedDay!.day}", "free"), 
            builder: (context, snapshot) {
              return snapshot.hasData ? LessonsBooking(snapshot.data!) : const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}


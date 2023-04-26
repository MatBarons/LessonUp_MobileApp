import 'package:flutter/material.dart';
//import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:progetto_ium/BuyPageWidgets/ListOfProfessorsAndDates.dart';
import 'package:progetto_ium/Common/Model/LessonModel.dart';
import 'package:progetto_ium/Common/Model/ProfessorModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

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
  List<Professor> pList = []; // lista di professori selezionati
  List<TimeOfDay> dList = []; // lista di ore selezionate
  late List<Professor> profList;
  List<String> profEmails = [];



  List<String> _filterProfessors(List<Professor> profs){
    List<String> comodo = [];
    for(Professor prof in profs){
      profEmails.add(prof.email);
    }
    return comodo;
  }

  void printProfList(List<Professor> l){
    for(int i=0;i<l.length;i++){
      print("nome: ${l[i].name} cognome: ${l[i].surname} email: ${l[i].email}");
    }
  }

  @override
  void initState(){
    super.initState();
    profEmails = _filterProfessors(pList);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              const SizedBox(width: 15),
              cardBuilder(context, 60, "Orari"),
              const SizedBox(width: 15),
              cardBuilder(context, 100, "Professori"),
              const SizedBox(width: 10),
            ],
          ),
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
              return snapshot.hasData ? LessonsBooking(ApiLecture().lectureByHourAndProfessor(profEmails, dList, snapshot.data!)) : const CircularProgressIndicator();
            },
          ),
          //tList.isNotEmpty ? LessonsBooking(tList) : placeholder
        ],
      ),
    );
  }

  Widget cardBuilder(BuildContext context,double width,String label){
    return GestureDetector(
      onTap: () async {
        if(width==60){
          dList = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListOfHours(tempListD,dList)));
          setState(() {});
        }else{
          profList = await ApiProfessor().getProfessorsBySubject(widget.s);
          printProfList(profList);
          try{
            pList = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListOfProfessors(profList,pList)));
          }catch (e){
            print("ERRORE: $e");
          }
          setState(() {});
        } 
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.7))
        ),
        height: 30,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: customText(label, 14, Theme.of(context).colorScheme.onTertiaryContainer, FontWeight.normal)),
            Icon(Icons.arrow_drop_down_outlined,color: Theme.of(context).colorScheme.onTertiaryContainer)
          ],
        )
      ),
    );
  }
}


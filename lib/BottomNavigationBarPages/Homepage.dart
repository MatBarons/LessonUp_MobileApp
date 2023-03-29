import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:progetto_ium/BuyPageWidgets/BuyPage.dart';
import 'package:progetto_ium/Common/Model/LessonModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: subjects(context),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 155, 0),
            child: customText("Le tue prossime lezioni:",18,Theme.of(context).colorScheme.onBackground,FontWeight.normal),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<Lecture>>(
            future: ApiLecture().getLecturesByStudentAndStatus("booked"),
            builder: (context, snapshot) {
              //print("suca: ${snapshot.data}");
              return snapshot.hasData ? 
              LessonsMain(snapshot.data!) : 
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.cancel,color: Colors.red,),
                    customText("Non hai nessuna lezione prenotata, prenota ora!", 15, Theme.of(context).colorScheme.onBackground, FontWeight.w500)
                  ],
                ),
              );
            },
          ),
        ],
      )
    );
  }
}

List<Widget> subjects(BuildContext context){
  return <Widget>[
    singleSubject("Matematica", Colors.purple[400]!, Icons.plus_one,context),
    singleSubject("Letteratura", Colors.red, Icons.abc_rounded,context),
    singleSubject("Inglese", Colors.blue,Icons.abc,context), //DA CAMBIARE

    singleSubject("Informatica", Colors.purple[400]!, Icons.computer_outlined,context),
    singleSubject("Storia", Colors.red, Icons.history_edu_outlined,context),
    singleSubject("Francese", Colors.blue,Icons.abc,context), //DA CAMBIARE

    singleSubject("Scienze", Colors.purple[400]!, Icons.science,context),
    singleSubject("Geografia", Colors.red, Icons.landscape,context),
    singleSubject("Tedesco", Colors.blue, Icons.abc,context), //DA CAMBIARE
  ];
}

Widget singleSubject(String label,Color color, IconData icon, BuildContext context){
  late List<Lecture> passedList;
  return Container(
    height: 70,
    width: 100,
    margin: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.7))

    ),
    child: GestureDetector(
      onTap: () async{
        //DateTime d = DateTime.now();
        //passedList = await ApiLecture().getLecturesBySubjectAndStatusAndDate(label.toLowerCase(), "${d.day}${d.month}${d.year}", "free");
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyPage(label.toLowerCase())));
      },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 4),
          customText(label, 17, Theme.of(context).colorScheme.onTertiaryContainer, FontWeight.normal),
        ],
      ),
    ),
  );
}

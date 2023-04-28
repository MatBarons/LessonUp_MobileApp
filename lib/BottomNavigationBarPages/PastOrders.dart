import 'package:flutter/material.dart';
import 'package:progetto_ium/Common/Model/LessonModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 17),
              customText("Da confermare", 20, Theme.of(context).colorScheme.onBackground, FontWeight.w500),
              const SizedBox(width: 200),
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder(
            future: ApiLecture().getLecturesByStudentAndStatus("completed"),
            builder: (context, snapshot) {
              return snapshot.hasData ? 
              LessonsOrders(snapshot.data!,false): 
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.cancel,color: Colors.red,),
                    customText("Nessuna lezione completata, datti da fare!", 15, Theme.of(context).colorScheme.onBackground, FontWeight.w500)
                  ],
                ),
              );
            }
          ),
          const Divider(endIndent: 5,thickness: 1,color: Colors.grey),
          Row(
            children: [
              const SizedBox(width: 17),
              customText("Già confermate", 20, Theme.of(context).colorScheme.onBackground, FontWeight.w500),
              const SizedBox(width: 200),
            ],
          ),
          const SizedBox(height: 18),
          FutureBuilder(
            future: ApiLecture().getLecturesByStudentAndStatus("ended"),
            builder: (context, snapshot) {
              return snapshot.hasData ? 
              LessonsOrders(snapshot.data!,true) : 
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.cancel,color: Colors.red,),
                    customText("Nessuna lezione confermata, conferma qualcosa di prego!", 12, Theme.of(context).colorScheme.onBackground, FontWeight.w500)
                  ],
                ),
              );
            },
          )
        ],
      )
    );
  }
}
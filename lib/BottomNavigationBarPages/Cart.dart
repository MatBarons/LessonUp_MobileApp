import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:progetto_ium/Common/Model/LessonModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {


  List<Lecture> emptyList = [];

  

  @override
  void initState(){
    super.initState();
  }


  String labelDismissable = " Scorri per ordinare";
  Icon iconDismissable = const Icon(Icons.arrow_forward);
  Color colorDismissable = Colors.orange[500]!;
  DismissDirection directionDismissable = DismissDirection.startToEnd;

  String labelEmpty = "Non c'è nessuna lezione qui, prenotane una!";
  Icon iconEmpty = const Icon(Icons.cancel_outlined, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          FutureBuilder(
            future: SessionManager().get("cart_list"),
            builder: (context, snapshot) {
              return snapshot.hasData ? LessonsCart(snapshot.data) : 
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconEmpty,
                    const SizedBox(height: 10),
                    customText(labelEmpty, 17, Theme.of(context).colorScheme.onBackground, FontWeight.bold),
                  ],
                ),
              );
            },
          ),
          Divider(color: Theme.of(context).colorScheme.onBackground,thickness: 1),
          Container(
            color: Theme.of(context).colorScheme.background,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText("Totale", 20, Theme.of(context).colorScheme.onBackground, FontWeight.bold),
                      const SizedBox(height: 10),
                      FutureBuilder(
                        future: SessionManager().get("cart_list"),
                        builder: (context, snapshot) {
                          return customText(snapshot.hasData ? snapshot.data!.length.toString() : "0", 17, Theme.of(context).colorScheme.onBackground, FontWeight.normal);
                        },
                      )
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: directionDismissable,
                    background: customContainer(const CircularProgressIndicator(), Theme.of(context).colorScheme.primary.withOpacity(0.7), "Pagamento in corso",context),
                    onDismissed: (customDirection) {
                      setState(() {
                        if (customDirection == DismissDirection.startToEnd) {
                        iconDismissable = const Icon(Icons.check);
                        labelDismissable = "Pagamento confermato";
                        colorDismissable = Theme.of(context).colorScheme.primary;
                        directionDismissable = DismissDirection.none;
                        
                        iconEmpty = Icon(Icons.check, color: Theme.of(context).colorScheme.primary);
                        labelEmpty = "Grazie per aver acquistato!";
                      }
                      });
                    },
                    child: customContainer(iconDismissable, colorDismissable, labelDismissable,context),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Container customContainer(Widget icon, Color color, String label, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: color),
    width: 180,
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        customText(label, 12, Theme.of(context).colorScheme.onBackground.withOpacity(0.8), FontWeight.w600),
        const SizedBox(width: 5),
        icon
      ],
    ),
  );
}
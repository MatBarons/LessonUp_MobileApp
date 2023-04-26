import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:progetto_ium/Common/Model/LessonModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

class LessonsMain extends StatefulWidget {
  LessonsMain(this.list,{super.key});
  List<Lecture> list;

  @override
  State<LessonsMain> createState() => _LessonsMainState();
}

class _LessonsMainState extends State<LessonsMain> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  void _removeLesson(int i) {
    _key.currentState!.removeItem(
      i,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            margin: const EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: customText("Deleted", 24, Colors.black, FontWeight.normal),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    widget.list.removeAt(i);
    ApiLecture().changeStatusAndStudent(widget.list[i],"free",null);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
      key: _key,
      initialItemCount: widget.list.length,
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          key: UniqueKey(),
          sizeFactor: animation,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondaryContainer
                ),
                padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //IMMAGINE
                    const CircleAvatar(
                      //backgroundImage: ,
                      radius: 25,
                    ),
                    const SizedBox(width: 15),
                    //COLONNA SCRITTE
                    Column(
                      children: [
                        customText(widget.list[index].subject, 12, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 3),
                        customText("${widget.list[index].name} ${widget.list[index].surname}", 17, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            customText(widget.list[index].time.substring(0,5), 12, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                            const SizedBox(width: 8),
                            customText(widget.list[index].date, 12, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal)
                          ],
                        ) 
                      ]
                    ),
                    const SizedBox(height: 15),
                    //ADD TO CALENDAR
                    IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month)),
                    //CANCELLA
                    IconButton(onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              surfaceTintColor: Theme.of(context).colorScheme.background,
                              backgroundColor: Theme.of(context).colorScheme.background,
                              buttonPadding: const EdgeInsets.all(30),
                              title: customText("Sei sicuro di voler eliminare la prenotazione?", 12, Theme.of(context).colorScheme.onBackground, FontWeight.bold),
                              actions: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        _removeLesson(index);
                                        //changeStatus to Free
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        padding: const EdgeInsetsDirectional.fromSTEB(10, 13, 0, 0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.error,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: customText("Elimina", 18, Theme.of(context).colorScheme.onError, FontWeight.normal),
                                      ),
                                    ),
                                    const SizedBox(width: 70),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 80,
                                        padding: const EdgeInsetsDirectional.fromSTEB(7, 13, 0, 0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondaryContainer,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: customText("Mantieni", 18, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          });
                      });
                    }, icon: const Icon(Icons.delete),color: Colors.red[500]),
                    
                  ],
                ),
              ),
              const SizedBox(height: 10)
            ]
          ),
        );
      },
    )
  );
  }
}

class LessonsCart extends StatefulWidget {
  LessonsCart(this.list,{super.key});
  List<Lecture> list;

  @override
  State<LessonsCart> createState() => _LessonsCartState();
}

class _LessonsCartState extends State<LessonsCart> {

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  void _removeLesson(int i) {
    _key.currentState!.removeItem(
      i,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: Card(
            margin: const EdgeInsets.all(10),
            color: Colors.red,
            child: ListTile(
              title: customText("Deleted", 24, Colors.black, FontWeight.normal),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    widget.list.removeAt(i);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
      key: _key,
      initialItemCount: widget.list.length,
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          key: UniqueKey(),
          sizeFactor: animation,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondaryContainer
                ),
                padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //IMMAGINE
                    const CircleAvatar(
                      //backgroundImage: ,
                      radius: 25,
                    ),
                    //COLONNA SCRITTE
                    Column(
                      children: [
                        customText(widget.list[index].subject, 12, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 3),
                        customText("${widget.list[index].name} ${widget.list[index].surname}", 17,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            customText(widget.list[index].time.substring(0,5), 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                            const SizedBox(width: 8),
                            customText(widget.list[index].date, 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal)
                          ],
                        ) 
                      ]
                    ),
                    const SizedBox(height: 15),
                    //CANCELLA
                    IconButton(
                      onPressed: () {
                        _removeLesson(index);
                      setState(() {});
                      }, 
                      icon: const Icon(Icons.delete),
                      color: Colors.red[500]),
                  ],
                ),
              ),
              const SizedBox(height: 10)
            ]
          ),
        );
      },
    )
  );
  }
}

class LessonsOrders extends StatefulWidget {
  LessonsOrders(this.list,this.isConfirmed,{super.key});

  List<Lecture> list;
  bool isConfirmed;
  @override
  State<LessonsOrders> createState() => _LessonsOrdersState();
}

class _LessonsOrdersState extends State<LessonsOrders> {

  Icon icon = const Icon(Icons.thumb_up_outlined);  

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
      shrinkWrap: true,
      initialItemCount: widget.list.length,
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      itemBuilder: (context, index, animation) {
        return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:  Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //IMMAGINE
                      const CircleAvatar(
                        //backgroundImage: ,
                        radius: 25,
                      ),
                      const SizedBox(width: 15),
                      //COLONNA SCRITTE
                      Column(
                      children: [
                        customText(widget.list[index].subject, 12, Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 3),
                        customText("${widget.list[index].name} ${widget.list[index].surname}", 17,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            customText(widget.list[index].time.substring(0,5), 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                            const SizedBox(width: 8),
                            customText(widget.list[index].date, 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal)
                          ],
                        ) 
                      ]
                    ),
                      const SizedBox(height: 15),
                      widget.isConfirmed ? 
                      IconButton(onPressed: () {},icon:Icon(Icons.thumb_up_alt_rounded,color: Theme.of(context).colorScheme.primary)) :  
                      IconButton(
                        onPressed: () {
                          icon = Icon(Icons.thumb_up_alt_rounded,color: Theme.of(context).colorScheme.primary);
                          ApiLecture().changeStatus(widget.list[index],"ended");
                          setState(() {});
                          }, 
                        icon: icon),
                    ],
                  ),
                ),
                const SizedBox(height: 10)
              ]
            ),
          );
        },
      )
    );
  }
}

class LessonsBooking extends StatefulWidget {
  LessonsBooking(this.list,{super.key});

  List<Lecture> list;

  @override
  State<LessonsBooking> createState() => _LessonsBookingState();
}

class _LessonsBookingState extends State<LessonsBooking> {
  
  List<bool> isSelected = [];
  List<Lecture> cart = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedList(
      initialItemCount: widget.list.length,
      padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
      itemBuilder: (context, index, animation) {
        isSelected.add(false);
        return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:  Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //IMMAGINE
                      const CircleAvatar(
                        //backgroundImage: ,
                        radius: 25,
                      ),
                      const SizedBox(width: 15),
                      //COLONNA SCRITTE
                      Column(
                      children: [
                        customText(widget.list[index].subject, 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 3),
                        customText("${widget.list[index].name} ${widget.list[index].surname}", 17,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            customText(widget.list[index].time.substring(0,5), 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal),
                            const SizedBox(width: 8),
                            customText(widget.list[index].date, 12,  Theme.of(context).colorScheme.onSecondaryContainer, FontWeight.normal)
                          ],
                        ) 
                      ]
                    ),
                      const SizedBox(height: 15),
                      //CANCELLA
                      IconButton(
                        onPressed: () async{
                          if (await SessionManager()
                                        .containsKey("cart_list")) {
                                      String json =
                                          await (SessionManager().get("cart_list"));
                                      cart = lectureFromJson(json);
                                      cart.add(widget.list[index]);
                                      await SessionManager()
                                          .set("cart_list", lecturesToJson(cart));
                                    } else {
                                      List<Lecture> l = [];
                                      l.add(widget.list[index]);
                                      await SessionManager()
                                          .set("cart_list", lecturesToJson(l));
                                    }
                          setState(() {
                            isSelected[index] = !isSelected[index];
                          });
                        }, 
                        icon: isSelected[index] ? Icon(Icons.check,color: Theme.of(context).colorScheme.primary) : Icon(Icons.add,color: Theme.of(context).colorScheme.onTertiaryContainer)
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10)
              ]
            ),
          );
        },
      )
    );
  }
}


SizedBox placeholder = const SizedBox(height: 0,width: 0,);
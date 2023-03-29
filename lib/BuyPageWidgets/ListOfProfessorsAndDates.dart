import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';

import 'package:progetto_ium/Common/Model/ProfessorModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

class ListOfProfessors extends StatefulWidget {

  ListOfProfessors(this.listOfAllProf,this.listOfSelectedProf,{super.key});
  List<Professor> listOfAllProf;
  List<Professor> listOfSelectedProf;

  @override
  State<ListOfProfessors> createState() => _ListOfProfessorsState();
}

class _ListOfProfessorsState extends State<ListOfProfessors> {

  List<bool> isSelected = [];
  List<Professor> listSelectedProfessors = [];

  bool isProfessorInList(String email){
    if(listSelectedProfessors.isEmpty){
      return false;
    }
    for(int i=0; i < listSelectedProfessors.length; i++){
      if(listSelectedProfessors[i].email == email){
        return true;
      }
    }
    return false;
  }

  void updateListProf(Professor prof){
    if(isProfessorInList(prof.email)){
      listSelectedProfessors.remove(prof);
    }else{
      listSelectedProfessors.add(prof);
    }
  }

  //future builder -> collega il SessionManager
  @override
  Widget build(BuildContext context) {
    listSelectedProfessors = widget.listOfSelectedProf;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.close,color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: customText("Professori", 17,Theme.of(context).colorScheme.onPrimary, FontWeight.normal),
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            itemCount: widget.listOfAllProf.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index){
              isSelected.add(isProfessorInList(widget.listOfAllProf[index].email));
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: CircleAvatar(
                      //backgroundImage: widget.listOfAllProf[index].image,
                      radius: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 60, 0),
                    child: customText("${widget.listOfAllProf[index].name} ${widget.listOfAllProf[index].surname}", 20, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                  ),
                  IconButton(
                    onPressed: () {
                      updateListProf(widget.listOfAllProf[index]);
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                    }, 
                    icon: isSelected[index] ? Icon(Icons.check_box,color: Theme.of(context).colorScheme.onBackground) : Icon(Icons.check_box_outline_blank,color: Theme.of(context).colorScheme.onBackground),
                  ),
                ]
              );
            }
          ),
      )
    );
  }
}


class ListOfHours extends StatefulWidget {
  ListOfHours(this.listOfAllHours,this.listOfSelectedHours,{super.key});

  List<TimeOfDay> listOfAllHours;
  List<TimeOfDay> listOfSelectedHours;

  @override
  State<ListOfHours> createState() => _ListOfHoursState();
}

class _ListOfHoursState extends State<ListOfHours> {
  
  List<bool> isSelected = [];
  List<TimeOfDay> listSelectedHours = [];
  

  bool isDateInList(TimeOfDay time){
    if(listSelectedHours.isEmpty){
      return false;
    }
    for(int i=0; i < listSelectedHours.length; i++){
      if(listSelectedHours[i] == time){
        return true;
      }
    }
    return false;
  }

  void updateListDate(TimeOfDay time){
    if(isDateInList(time)){
      listSelectedHours.remove(time);
    }else{
      listSelectedHours.add(time);
    }
  }


  
  @override
  Widget build(BuildContext context) {
    listSelectedHours = widget.listOfSelectedHours;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.close,color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: customText("Orari", 17,Theme.of(context).colorScheme.onPrimary, FontWeight.normal),
      ),
      body: SingleChildScrollView(
        child: ListView.separated(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          itemCount: widget.listOfAllHours.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index){
            isSelected.add(isDateInList(widget.listOfAllHours[index]));
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: customText("${widget.listOfAllHours[index].hour}:00", 20, Theme.of(context).colorScheme.onBackground, FontWeight.normal),
                ),
                IconButton(
                  onPressed: () {
                    updateListDate(widget.listOfAllHours[index]);
                    setState(() {
                      isSelected[index] = !isSelected[index];
                    });
                  }, 
                  icon: FutureBuilder(
                    future: SessionManager().get("DateList"),
                    builder: (context, snapshot) {
                      return isSelected[index] ? Icon(Icons.check_box,color: Theme.of(context).colorScheme.onBackground) :  Icon(Icons.check_box_outline_blank,color: Theme.of(context).colorScheme.onBackground);
                    },
                  )
                ),
              ]
            );
          }
        ),
      )
    );
  }
}
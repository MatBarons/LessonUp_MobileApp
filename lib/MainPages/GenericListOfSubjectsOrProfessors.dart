import 'package:flutter/material.dart';
import 'package:progettoium/MainPages/CommonMainPagesWidgets/ProfessorCard.dart';
import 'package:progettoium/MainPages/CommonMainPagesWidgets/SubjectCard.dart';
import '../Utilities/CommonWidgets/CommonStyles.dart';

class GenericListOfSubjectsOrProfessors extends StatefulWidget {
  String? subject;
  String? professor;
  String? whichButton;
  GenericListOfSubjectsOrProfessors(this.subject,this.professor,this.whichButton,{Key? key}) : super(key: key);

  @override
  State<GenericListOfSubjectsOrProfessors> createState() => _GenericListOfSubjectsOrProfessorsState();
}

class _GenericListOfSubjectsOrProfessorsState extends State<GenericListOfSubjectsOrProfessors> {
  late String appBarText;
  late bool isSubjects;

  bool checkIfAllDone(){
    if(widget.professor != null && widget.subject != null){
      return true;
    }else{
      return false;
    }
  }

  @override
  void initState() {
    if(widget.whichButton == "Subjects"){
      appBarText = "Scegli la materia";
      isSubjects = true;
    }else if(widget.whichButton == "Professors"){
      appBarText = "Scegli il professore";
      isSubjects = false;
    }else{
      if(widget.subject == null && widget.professor != null){
        appBarText = "Scegli la materia";
        isSubjects = true;
      }else if(widget.subject != null && widget.professor == null){
        appBarText = "Scegli il professore";
        isSubjects = false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: customAppBar(placeholderBack, myText(appBarText, 20, Theme.of(context).colorScheme.onPrimary, FontWeight.w500), 60,context),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            getProfCards(Theme.of(context).colorScheme.tertiaryContainer).length,
            (index) => isSubjects ?
              subCard(context, getSubjectCards(Theme.of(context).colorScheme.tertiaryContainer)[index],widget.professor) :
              profCard(context,getProfCards(Theme.of(context).colorScheme.tertiaryContainer)[index],widget.subject)
          ),
        ),
      ),
    );
  }
}
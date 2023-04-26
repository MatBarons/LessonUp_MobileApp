import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';
import 'package:http/http.dart';


List<Lecture> lectureFromJson(String str) =>List<Lecture>.from(json.decode(str).map((x) => Lecture.fromJson(x)));


String lecturesToJson(List<Lecture>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())).toString());

String ip = "172.18.110.67:8080";

class Lecture{
  String name;
  String surname;
  String email;
  String subject;
  //NetworkImage? image;
  String date;
  String time;

  Lecture({
    required this.name,
    required this.surname,
    required this.subject,
    required this.email,
    required this.date,
    required this.time,
  });

  

  factory Lecture.fromJson(Map<String, dynamic> json){
    return Lecture(
      date: json["date"],
      time : json["time"],
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      subject: json["subject"],
    );
  }

  Map<String, dynamic> toJson() => {
    "\"date\"": "\"" + date + "\"",
    "\"time\"": "\"" + time + "\"",
    "\"name\"": "\"" + name + "\"",
    "\"surname\"": "\"" + surname + "\"",
    "\"email\"": "\"" + email + "\"",
    "\"subject\"": "\"" + subject + "\"",
  };

  


}

class ApiLecture{
  ApiLecture();

  Future<List<Lecture>> getLecturesByStudentAndStatus(String status) async {
    String email = await SessionManager().get("email");
    Response response = await get(
      Uri.parse("http://$ip/backend/api/lecture?path=getAllLecturesByStudentAndStatus&student=$email&status=$status"),
      //headers: {"email":x,"role":"student"}
      );
    if(response.statusCode == 200){
      List<Lecture> lectures = [];
      try{
        final List<dynamic> lecturesJson = jsonDecode(response.body);
        lectures = lecturesJson.map((json) => Lecture.fromJson(json)).toList();
      }catch(e){
        print("Errore durante la conversione dei dati JSON: $e");
      }
      return lectures;
    }else{
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Lecture>> getLecturesBySubjectAndStatusAndDate(String subject,String d,String status) async {
    Response response = await get(Uri.parse('http://$ip/backend/api/lecture?path=getAllLecturesBySubjectAndStatusAndDate&subject=$subject&status=$status&date=$d'));
    if(response.statusCode == 200){
      final List<dynamic> lecturesJson = jsonDecode(response.body);
      final List<Lecture> lectures = lecturesJson.map((json) => Lecture.fromJson(json)).toList();
      return lectures;
    }else{
      throw Exception('Unexpected error occured!');
    }
  }

  void changeStatus(Lecture lecture,String status) async{
    String day = lecture.date.substring(0,2);
    String month = lecture.date.substring(3,5);
    String year = lecture.date.substring(6,9);
    String newDate = "$year-$month-$day";
    
    Response response = await post(
      Uri.parse('http://$ip/backend/api/lecture?path=changeStatus&status=$status&date=$newDate&time=${lecture.time}&subject=${lecture.subject}&professor=${lecture.email}'),
    );
    if(response.statusCode == 200){
      print("status changed correctly");
    }else{
      throw Exception('Unexpected error occured!');
    }
  }

  void changeStatusAndStudent(Lecture lecture,String status,String? student) async{
    print("studente: $student");
    print("time: ${lecture.time}");
    String time = "${lecture.time}:00";
    print("time2: $time");
    String day = lecture.date.substring(0,2);
    String month = lecture.date.substring(3,5);
    String year = lecture.date.substring(6,10);
    String newDate = "$year-$month-$day";
    Response response = await post(
      Uri.parse('http://$ip/backend/api/lecture?path=changeStatusAndStudent&status=$status&student=$student&date=$newDate&time=$time&subject=${lecture.subject}&professor=${lecture.email}'),
    );
    if(response.statusCode == 200){
      print("status and student changed correctly");
    }else{
      throw Exception('Unexpected error occured!');
    }
  }

  List<Lecture> lectureByHourAndProfessor(List<String> prof,List<TimeOfDay> time, List<Lecture> listOfAll){
    List<Lecture> list = [];
    List<Lecture> tempList = [];
    print("professori: $prof");
    print("orario: $time");
    bool flag = false;
    if(prof.isNotEmpty || time.isNotEmpty){
      print("Prova14214");
      if(prof.isNotEmpty && time.isEmpty){
        for(int i=0;i<listOfAll.length;i++){
          for(int j=0;i<prof.length && flag == false;j++){
            if(listOfAll[i].email == prof[j]){
              list.add(listOfAll[i]);
              flag = true;
            }
          }
          flag = false;
        }
      }else if(prof.isEmpty && time.isNotEmpty){
        for(int i=0;i<listOfAll.length;i++){
          for(int j=0;j<time.length && flag == false;j++){
            if(listOfAll[i].time.substring(0,1) == time[j].hour.toString()){
              list.add(listOfAll[i]);
              flag = true;
            }
            flag = false;
          }
        }
      }else if(prof.isNotEmpty && time.isNotEmpty){
        for(int i=0;i<listOfAll.length;i++){
          for(int j=0;i<prof.length && flag == false;j++){
            if(listOfAll[i].email == prof[j]){
              list.add(listOfAll[i]);
              flag = true;
            }
          }
          flag = false;
        }
        flag = false;
        tempList = list;
        for(int i=0;i<list.length;i++){
          for(int j=0;i<time.length && flag == false;j++){
            if(list[i].time.substring(0,1) == time[j].hour.toString()){
              flag = true;
            }
          }
          if(flag == false){
            list.remove(list[i]);
          }
          flag = false;
        }
      }
    }else if(prof.isEmpty && time.isEmpty){
      list = listOfAll;
      print("succo di frutta");
    }
    print("sesso duro: $list");
    return list;
  }

}


List<TimeOfDay> tempListD = [
  const TimeOfDay(hour: 14, minute: 00),
  const TimeOfDay(hour: 15, minute: 00),
  const TimeOfDay(hour: 16, minute: 00),
  const TimeOfDay(hour: 17, minute: 00),
  const TimeOfDay(hour: 18, minute: 00),
];
/*
List<Lecture> tempList = [
  Lecture(name: "Matteo",surname: "Barone",email: "matteo.barone@mail.com",subject: "Matematica",date: "13/09/2001",time: "14:00",image: null),
  Lecture(name: "Lucia", surname: "Calandra", email: "lucia.calandra@mail.com", subject: "Letteratura", date: "13/09/2001",image: null),
  Lecture(name: "Paola", surname: "Pane", email: "paola.pane@mail.com", subject: "Inglese", datetime: DateTime.now(),image: null),
  Lecture(name: "Andrea", surname: "Barone", email: "andrea.barone@mail.com", subject: "Fisica", datetime: DateTime.now(),image: null),
  Lecture(name: "Giovanni", surname: "Pane", email: "giovanni.pane@mail.com", subject: "Storia", datetime: DateTime.now(),image: null)
];



*/
//Creare metodo di fetch delle lezioni in base alla materia

//Creare metodo di ricerca tra le lezioni fetchate in base ai prof

//Creare metodo di ricerca tra le lezioni fetchate in base all'orario
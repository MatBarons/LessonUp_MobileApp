import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';
import 'package:http/http.dart';


List<Lecture> lectureFromJson(String str) =>List<Lecture>.from(json.decode(str).map((x) => Lecture.fromJson(x)));


String lecturesToJson(List<Lecture>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJsonDisplay())).toString());

String ip = "192.168.1.11:8080";

class Lecture{
  String? name;
  String? surname;
  String email;
  String subject;
  String date;
  String time;
  String? status;
  String? student;

  Lecture.display({
    required this.name,
    required this.surname,
    required this.subject,
    required this.email,
    required this.date,
    required this.time,

  });

  Lecture.toSend({
    required this.subject,
    required this.email,
    required this.date,
    required this.time,
    required this.status,
    required this.student
  });

  factory Lecture.fromJson(Map<String, dynamic> json){
    return Lecture.display(
      date: json["date"],
      time : json["time"],
      name: json["name"],
      surname: json["surname"],
      email: json["email"],
      subject: json["subject"],
    );
  }
  

  Map<String, dynamic> toJsonDisplay() => {
    "\"date\"": "\"" + date + "\"",
    "\"time\"": "\"" + time + "\"",
    "\"name\"": "\"" + name! + "\"",
    "\"surname\"": "\"" + surname! + "\"",
    "\"email\"": "\"" + email + "\"",
    "\"subject\"": "\"" + subject + "\"",
  };

  Map<String,dynamic> toJsonToSend() =>{
    'date': date,
    'time': time,
    'professor': email,
    'subject': subject,
    'status': status,
    'student': student,
  };



}

class ApiLecture{
  ApiLecture();

  Future<List<Lecture>> getLecturesByStudentAndStatus(String status) async {
    String email = await SessionManager().get("email");
    String token = await SessionManager().get("token");
    Response response = await get(
      Uri.parse("http://$ip/backend/api/lecture?path=getAllLecturesByStudentAndStatus&student=$email&status=$status"),
      headers: {
        'Authorization': token
      }
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
    String token = await SessionManager().get("token");
    Response response = await get(
      Uri.parse('http://$ip/backend/api/lecture?path=getAllLecturesBySubjectAndStatusAndDate&subject=$subject&status=$status&date=$d'),
      headers: {
        'Authorization': token
      }
      );
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
    String newTime = "${lecture.time}:00";
    Lecture newLecture = Lecture.toSend(
      subject: lecture.subject, 
      email: lecture.email, 
      date: newDate, 
      time: newTime, 
      status: status, 
      student: null
      );
    String token = await SessionManager().get("token");
    Response response = await put(
      Uri.parse('http://$ip/backend/api/lecture?path=changeStatus'),
      body: json.encode(newLecture.toJsonToSend()),
      headers: {
        'Authorization': token
      }
    );
    if(response.statusCode == 200){
      print("status changed correctly");
    }else{
      throw Exception('Unexpected error occured!');
    }
  }

  void changeStatusAndStudent(Lecture lecture,String status,String? student) async{
    String time = "${lecture.time}:00";
    String day = lecture.date.substring(0,2);
    String month = lecture.date.substring(3,5);
    String year = lecture.date.substring(6,10);
    String newDate = "$year-$month-$day";
    String newTime = "${lecture.time}:00";
    Lecture newLecture = Lecture.toSend(
      subject: lecture.subject, 
      email: lecture.email, 
      date: newDate, 
      time: newTime, 
      status: status, 
      student: student
      );
    String token = await SessionManager().get("token");
    Response response = await put(
      Uri.parse('http://$ip/backend/api/lecture?path=changeStatusAndStudent'),
      body: json.encode(newLecture.toJsonToSend()),
      headers: {
        'Authorization': token
      }
    );
    if(response.statusCode == 200){
      print("status and student changed correctly");
    }else{
      throw Exception('Unexpected error occured!');
    }
  }
}


List<TimeOfDay> tempListD = [
  const TimeOfDay(hour: 14, minute: 00),
  const TimeOfDay(hour: 15, minute: 00),
  const TimeOfDay(hour: 16, minute: 00),
  const TimeOfDay(hour: 17, minute: 00),
  const TimeOfDay(hour: 18, minute: 00),
];
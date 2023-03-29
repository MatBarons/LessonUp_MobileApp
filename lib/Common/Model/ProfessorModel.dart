import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart';

List<Professor> professorFromJson(String str) =>List<Professor>.from(json.decode(str).map((x) => Professor.fromJson(x)));

String professorToJson(List<Professor>? data) => json.encode(data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())).toString());

String ip = "172.18.103.129:8080";

class Professor{
  String name;
  String surname;
  String email;
  //NetworkImage? image;

  Professor({
    required this.name,
    required this.surname,
    required this.email,
    //this.image
  });

  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
  );

  
  Map<String, dynamic> toJson() => {
    "\"name\"": "\"" + name + "\"",
    "\"surname\"": "\"" + surname + "\"",
    "\"email\"": "\"" + email + "\"",
    //"\"image_url\"": "\"" + image!.url + "\"",
  };
  

 

}

class ApiProfessor{

  ApiProfessor();

  Future<List<Professor>> getProfessorsBySubject(String subject) async{
    Response response = await get(Uri.parse("http://$ip/backend/api/user?path=getProfessorsBySubject&subject=$subject"));
    if(response.statusCode == 200){
      final List<dynamic> professorsJson = jsonDecode(response.body);
      final List<Professor> professors = professorsJson.map((json) => Professor.fromJson(json)).toList();
      return professors;
    }else{
      throw Exception('Unexpected error occured!');
    }
  }
  
  Future<bool> login(String email,String password) async {
    print(email);
    print(password);
    Response response = await get(Uri.parse("http://$ip/backend/api/user?path=logMeIn&email=$email&password=$password"));
    if(response.statusCode == 200){
      return true;
    }else{
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }
}





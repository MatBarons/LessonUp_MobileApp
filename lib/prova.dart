import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'Common/StylesAndWidgets/CommonWidgets.dart';

class Prova extends StatefulWidget {
  const Prova({super.key});

  @override
  State<Prova> createState() => _ProvaState();
}

class _ProvaState extends State<Prova> {

  late String text;

  void prova() async{
    print("PROVA");
    var response = await get(Uri.parse("http://172.18.103.109:8080/backend/api/PROVA"));
    
    print(response);
    
    
    

  }

  @override
  void initState() async{
    prova();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return placeholder;
  }
}
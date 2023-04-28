import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import 'package:progetto_ium/Common/Model/ProfessorModel.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/CommonWidgets.dart';
import 'package:progetto_ium/Common/StylesAndWidgets/TextStylesAndColors.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget loggedRow = placeholder;
  bool isLogged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        toolbarHeight: 70,
        title: customText("Login", 20,Theme.of(context).colorScheme.onPrimary , FontWeight.w500)
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: passwordController,
            //obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () async{
              isLogged = await ApiProfessor().login(emailController.text.toString().toLowerCase(),passwordController.text.toString());
              if(isLogged){
                SessionManager().set("email", emailController.text.toString().toLowerCase());
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Root()));
              }else{
                loggedRow = Row(
                  children: [
                    const Icon(Icons.cancel,color: Colors.red,),
                    const SizedBox(width: 5),
                    customText("Il login è errato", 17, Colors.red, FontWeight.w500)
                  ],
                );
                setState(() {});
              }
              
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)
              ),
              height: 50,
              child: Center(child: customText("Login", 20, Theme.of(context).colorScheme.onPrimary, FontWeight.normal)),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              SessionManager().set("email", null);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Root()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10)
              ),
              height: 50,
              child: Center(child: customText("Ospite", 20, Colors.black, FontWeight.normal)),
            ),
           
          ),
          loggedRow
        ],
      ),
    );
  }
}
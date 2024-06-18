import 'package:flutter/material.dart';
import 'package:app_quiz/LandingPage.dart';
import 'package:app_quiz/CriarConta.dart';
void main() {
  runApp(const MyApp());
}
 class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: 'Flutter App',
       theme:ThemeData(
         primarySwatch: Colors.blue,
       ),

       home: LandingPage(),
     );
   }
 }

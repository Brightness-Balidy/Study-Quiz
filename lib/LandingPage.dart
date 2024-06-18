import 'package:flutter/material.dart';
import 'package:app_quiz/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_quiz/LoginPage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
          height: size.height,
          width: size.width,
          decoration:BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,end: Alignment.bottomCenter,
              colors: [
                AppColors.bgColor,
                AppColors.gradientColor,
              ],
            ),


          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoquiz.png'),
              //FlutterLogo(size: 100),
              SizedBox(height:10),
              Text('Study Quiz',
                style: GoogleFonts.gruppo(color: AppColors.selectedColor, fontSize: 70, fontWeight: FontWeight.bold),
              ),
              SizedBox(height:10),
              /*Text('Quiz do estudante',
                style: GoogleFonts.gruppo(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
              SizedBox(height:10),
              Text('responda e aprenda',
                style: GoogleFonts.gruppo(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height:10),
              Container(
                width: size.width * 0.5,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary:AppColors.buttonColor),
                  child: Text('Iniciar',
                    style:GoogleFonts.gruppo(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyLogin()));
                  },
                ),
              )
            ],
          ),
        )


    );
  }
}

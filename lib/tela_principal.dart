import 'package:app_quiz/question.dart';
import 'package:flutter/material.dart';
import 'package:app_quiz/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_quiz/QuizController.dart';

QuizController qc = QuizController();

class PrincipalTela extends StatefulWidget {
  const PrincipalTela({Key? key}) : super(key: key);

  @override
  _PrincipalTelaState createState() => _PrincipalTelaState();
}

List<Icon> scoreTracker = [];

class _PrincipalTelaState extends State<PrincipalTela> {
  void checkAnswer(bool userAnswer) {
    setState(() {
      if (userAnswer == qc.getCorrectAnswer) {
        scoreTracker.add(
          Icon(
            Icons.check_circle,
            color: AppColors.selectedColor,
          ),

        );

      } else {
        scoreTracker.add(
          Icon(
            Icons.close_rounded,
            color: Colors.red,
          ),
        );
      }
    });
    qc.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.gradientColor,
      appBar: AppBar(
        title: Text('Study Quiz'),
        centerTitle: true,
        backgroundColor: Colors.transparent, //tornar a appbar transparente
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    qc.getQuestion,
                    style: GoogleFonts.gruppo(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedColor,
                  ),
                  child: Text(
                    'VERDADEIRO',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      checkAnswer(true);

                    });
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    checkAnswer(false);
                  },
                  child: Text(
                    'FALSO',
                    style: GoogleFonts.gruppo(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: scoreTracker,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

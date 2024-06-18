import 'question.dart';
class QuizController {
  int _questionNumber = 0;
  List<Question> questions = [
    Question(
        question: 'Os requisitos para instalar o active directory sao: DNS e Senha forte, ',
        answer: true),
    Question(
        question: 'no redirecionamento de pastas: o admin deve conhecer as pastas que sao redirecionadas',
        answer: true),
    Question(
        question: 'no redirecionamento de pastas: O admin deve poder modificar e acessar as pastas dos usuario na rede',
        answer: false),
    Question(question: 'O Sistema Operacional Windows foi feito pela IBM',
        answer: false),
    Question(
        question: 'Todas as versoes do windows Server suportam a virtualizacao',
        answer: false),
  ];

  String get getQuestion => questions[_questionNumber].question;
  bool get getCorrectAnswer => questions[_questionNumber].answer;


  void nextQuestion() {
    if (_questionNumber < questions.length - 1) {
      _questionNumber++;
    }
  }
}
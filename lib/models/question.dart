import 'package:html_unescape/html_unescape.dart';

class Question{
  final String questionText;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const Question({
    required this.questionText,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Question.fromJson(Map<String,dynamic> json){
    HtmlUnescape unescape=HtmlUnescape();
    List<dynamic> rawWrongAnswers=json['incorrect_answers'];
    List<String> decodedWrongAnswers=[];

    for(int i=0;i<rawWrongAnswers.length;i++){
      String decodedText=unescape.convert(rawWrongAnswers[i]);
      decodedWrongAnswers.add(decodedText);
    }

    String decodedQuestion=unescape.convert(json['question']);
    String decodedCorrect=unescape.convert(json['correct_answer']);

    return Question(
      questionText:decodedQuestion,
      correctAnswer:decodedCorrect,
      incorrectAnswers:decodedWrongAnswers,
    );
  }

  List<String> getAllAnswers(){
    List<String> answers=[];
    for(int i=0;i<incorrectAnswers.length;i++){
      answers.add(incorrectAnswers[i]);
    }
    answers.add(correctAnswer);
    answers.shuffle();
    return answers;
  }
}
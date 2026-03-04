import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/quiz_provider.dart';
import '../models/question.dart';
import '../widgets/answer_button.dart';

class QuizScreen extends ConsumerWidget{
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref){
    QuizState quizState=ref.watch(quizProvider);
    QuizNotifier quizNotifier=ref.read(quizProvider.notifier);
    return Scaffold(
      body:SafeArea(
        child:_buildBody(quizState,quizNotifier),
      ),
    );
  }

  List<Widget> _buildAnswerButtons(List<String> answers,QuizNotifier notifier){
    List<Widget> buttonWidgets=[];
    for(int i=0;i<answers.length;i++){
      String currentAnswer=answers[i];
      Widget newButton=AnswerButton(
        answerText:currentAnswer,
        onClick:(){
          notifier.submitAnswer(currentAnswer);
        },
      );
      buttonWidgets.add(newButton);
    }
    return buttonWidgets;
  }

  Widget _buildBody(QuizState state,QuizNotifier notifier){
    if(state.isLoading==true){
      return const Center(
        child:CircularProgressIndicator(color:Colors.white),
      );
    }

    if(state.error!=''){
      return Center(
        child:Text(
          state.error,
          style:const TextStyle(color:Colors.white),
        ),
      );
    }

    bool isNotEmpty=state.questions.isNotEmpty;
    bool isFinished=state.currentIndex>=state.questions.length;

    if(isNotEmpty&&isFinished){
      return Center(
        child:Padding(
          padding:const EdgeInsets.all(24.0),
          child:Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              const Text(
                'HOLY GHOT-',
                style:TextStyle(fontSize:32.0,fontWeight:FontWeight.bold,color:Colors.white),
              ),
              const SizedBox(height:32.0),
              Container(
                decoration:BoxDecoration(
                  shape:BoxShape.circle,
                  color:const Color(0xFFFF9800),
                  border:Border.all(color:Colors.white30,width:8.0),
                ),
                padding:const EdgeInsets.all(32.0),
                child:const Icon(
                  Icons.check,
                  size:64.0,
                  color:Colors.white,
                ),
              ),
              const SizedBox(height:32.0),
              Text(
                'You Earned ${state.score*10} bits-coin',
                style:const TextStyle(fontSize:20.0,color:Colors.white),
              ),
              const SizedBox(height:64.0),
              SizedBox(
                width:double.infinity,
                child:ElevatedButton(
                  onPressed:(){
                    notifier.restart();
                  },
                  style:ElevatedButton.styleFrom(
                    backgroundColor:const Color(0xFFFF9800),
                    foregroundColor:Colors.white,
                    padding:const EdgeInsets.symmetric(vertical:20.0),
                    shape:RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(16.0),
                    ),
                  ),
                  child:const Text(
                    'Play Again',
                    style:TextStyle(fontSize:18.0,fontWeight:FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if(state.questions.isEmpty){
      return const Center(
        child:Text(
          'No questions found.',
          style:TextStyle(color:Colors.white),
        ),
      );
    }

    Question currentQuestion=state.questions[state.currentIndex];
    List<String> answers=currentQuestion.getAllAnswers();
    String cleanQuestionText=currentQuestion.questionText;
    double progress=(state.currentIndex+1)/state.questions.length;

    List<Widget> columnChildren=[];

    Widget topRow=Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children:[
        Text(
          'Question ${state.currentIndex+1}',
          style:const TextStyle(fontSize:18.0,fontWeight:FontWeight.bold,color:Colors.white),
        ),
        Container(
          padding:const EdgeInsets.symmetric(horizontal:12.0,vertical:6.0),
          decoration:BoxDecoration(
            color:Colors.white.withOpacity(0.2),
            borderRadius:BorderRadius.circular(12.0),
          ),
          child:Text(
            'Score: ${state.score*10}',
            style:const TextStyle(fontSize:16.0,fontWeight:FontWeight.bold,color:Colors.white),
          ),
        ),
      ],
    );
    columnChildren.add(topRow);
    columnChildren.add(const SizedBox(height:16.0));

    Widget progressBar=LinearProgressIndicator(
      value:progress,
      backgroundColor:Colors.white24,
      valueColor:const AlwaysStoppedAnimation<Color>(Color(0xFFFF9800)),
      minHeight:6.0,
      borderRadius:BorderRadius.circular(10.0),
    );
    columnChildren.add(progressBar);
    columnChildren.add(const SizedBox(height:40.0));

    Widget questionCard=Container(
      decoration:BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(24.0),
        boxShadow:const [
          BoxShadow(color:Colors.black12,blurRadius:10.0,offset:Offset(0.0,5.0)),
        ],
      ),
      padding:const EdgeInsets.all(32.0),
      child:Column(
        children:[
          const Icon(Icons.edit_note,size:48.0,color:Color(0xFFFF9800)),
          const SizedBox(height:16.0),
          Text(
            cleanQuestionText,
            style:const TextStyle(fontSize:22.0,fontWeight:FontWeight.bold,color:Color(0xFF4A148C)),
            textAlign:TextAlign.center,
          ),
        ],
      ),
    );
    columnChildren.add(questionCard);
    columnChildren.add(const SizedBox(height:40.0));

    List<Widget> buttonWidgets=_buildAnswerButtons(answers,notifier);
    for(int i=0;i<buttonWidgets.length;i++){
      columnChildren.add(buttonWidgets[i]);
    }

    return Padding(
      padding:const EdgeInsets.symmetric(horizontal:24.0,vertical:16.0),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children:columnChildren,
      ),
    );
  }
}
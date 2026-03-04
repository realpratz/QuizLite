import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question.dart';
import '../services/api_service.dart';

Provider<ApiService> apiServiceProvider=Provider<ApiService>((Ref ref){
  return ApiService();
});

class QuizState{
  final List<Question> questions;
  final int currentIndex;
  final int score;
  final bool isLoading;
  final String error;

  const QuizState({
    required this.questions,
    required this.currentIndex,
    required this.score,
    required this.isLoading,
    required this.error,
  });
}

class QuizNotifier extends Notifier<QuizState>{
  @override
  QuizState build(){
    Future.microtask((){
      fetchQuestions();
    });
    return const QuizState(
      questions:[],
      currentIndex:0,
      score:0,
      isLoading:false,
      error:'',
    );
  }

  Future<void> fetchQuestions() async{
    ApiService apiService=ref.read(apiServiceProvider);
    state=QuizState(
      questions:state.questions,
      currentIndex:state.currentIndex,
      score:state.score,
      isLoading:true,
      error:'',
    );
    try{
      List<Question> downloadedQuestions=await apiService.fetchQuestions();
      state=QuizState(
        questions:downloadedQuestions,
        currentIndex:state.currentIndex,
        score:state.score,
        isLoading:false,
        error:'',
      );
    }
    catch(error){
      state=QuizState(
        questions:state.questions,
        currentIndex:state.currentIndex,
        score:state.score,
        isLoading:false,
        error:error.toString(),
      );
    }
  }

  void submitAnswer(String selectedAnswer){
    if(state.questions.isEmpty){
      return;
    }
    Question currentQuestion=state.questions[state.currentIndex];
    int currentScore=state.score;
    if(currentQuestion.correctAnswer==selectedAnswer){
      currentScore=currentScore+1;
    }
    int nextIndex=state.currentIndex+1;
    state=QuizState(
      questions:state.questions,
      currentIndex:nextIndex,
      score:currentScore,
      isLoading:state.isLoading,
      error:state.error,
    );
  }

  void restart(){
    state=const QuizState(
      questions:[],
      currentIndex:0,
      score:0,
      isLoading:false,
      error:'',
    );
    fetchQuestions();
  }
}

NotifierProvider<QuizNotifier,QuizState> quizProvider=NotifierProvider<QuizNotifier,QuizState>((){
  return QuizNotifier();
});
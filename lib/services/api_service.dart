import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService{
  static const String _url='https://opentdb.com/api.php?amount=10&type=multiple';

  Future<List<Question>> fetchQuestions() async{
    try{
      Uri parsedUrl=Uri.parse(_url);
      http.Response response=await http.get(parsedUrl);

      if(response.statusCode==200){
        Map<String,dynamic> data=jsonDecode(response.body);
        if(data['response_code']==0){
          List<dynamic> rawResults=data['results'];
          List<Question> finalQuestions=[];
          for(int i=0;i<rawResults.length;i++){
            Map<String,dynamic> singleJsonItem=rawResults[i];
            Question parsedQuestion=Question.fromJson(singleJsonItem);
            finalQuestions.add(parsedQuestion);
          }
          return finalQuestions;
        }
        else{
          throw Exception('API Error');
        }
      }
      else{
        throw Exception('Failed to connect');
      }
    }
    catch(error){
      throw Exception(error.toString());
    }
  }
}
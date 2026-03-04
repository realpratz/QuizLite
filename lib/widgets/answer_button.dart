import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget{
  final String answerText;
  final VoidCallback onClick;

  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding:const EdgeInsets.only(bottom:16.0),
      child:SizedBox(
        width:double.infinity,
        child:ElevatedButton(
          onPressed:onClick,
          style:ButtonStyle(
            backgroundColor:WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states){
              bool isHovered=states.contains(WidgetState.hovered);
              bool isPressed=states.contains(WidgetState.pressed);
              if(isHovered||isPressed){
                return const Color(0xFFFF9800);
              }else{
                return const Color(0xFF9060F9);
              }
            }),
            foregroundColor:const WidgetStatePropertyAll<Color>(Colors.white),
            padding:const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical:20.0)),
            shape:WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(16.0),
                side:const BorderSide(color:Colors.white30,width:1.0),
              ),
            ),
            elevation:const WidgetStatePropertyAll<double>(0.0),
          ),
          child:Text(
            answerText,
            style:const TextStyle(fontSize:16.0,fontWeight:FontWeight.bold),
            textAlign:TextAlign.center,
          ),
        ),
      ),
    );
  }
}
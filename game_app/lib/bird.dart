import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  
  final birdy;
  final double barrierWidth;
  final double birdHeight;

  MyBird({this.birdy , required this.birdHeight, required this.barrierWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, (2 * birdy + birdHeight)/ (2 - birdHeight)),
      child: Image.asset('lib/images/bird.png',
      width: MediaQuery.of(context).size.height * barrierWidth / 2,
      height: MediaQuery.of(context).size.height * 3 / 4 * barrierWidth / 2,
      fit: BoxFit.fill,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class MyCoverScreen extends StatelessWidget {
  final bool gameHasStarted;

  const MyCoverScreen({Key? key, required this.gameHasStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !gameHasStarted
        ? Container(
            alignment: Alignment.center,
            color: Colors.blue, // Background color
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                
                const Spacer(),
                
              ],
            ),
          )
        : Container();
  }
}

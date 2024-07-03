import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_app/barrier.dart';
import 'package:game_app/bird.dart';
import 'package:game_app/coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdy = 0;
  double initialpos = birdy;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 2.5;
  double birdHeight = 0.1;
  double birdWidth = 0.1;

  // Game getting started
  bool gameHasStarted = false;

  // Barrier variables
  static List<double> barrierx = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdy = initialpos - height;
      });
      if (birdIsDead()) {
        timer.cancel();
        _showDialog();
      }
      moveMap();
      time += 0.01;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierx.length; i++) {
      setState(() {
        barrierx[i] -= 0.005;
      });
      if (barrierx[i] < -1.5) {
        barrierx[i] += 3;
      }
    }
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdy = 0;
      gameHasStarted = false;
      time = 0;
      initialpos = birdy;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Center(
            child: Text(
              "GAME OVER",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(17),
                  color: Colors.white,
                  child: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initialpos = birdy;
    });
  }

  bool birdIsDead() {
    if (birdy < -1 || birdy > 1) {
      return true;
    }
    for (int i = 0; i < barrierx.length; i++) {
      if (barrierx[i] <= barrierWidth &&
          barrierx[i] + barrierWidth >= -barrierWidth &&
          (birdy <= -1 + barrierHeight[i][0] ||
              birdy + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdy: birdy,
                        birdHeight: birdHeight,
                        barrierWidth: birdWidth,
                      ),
                     if (!gameHasStarted) 
                      MyCoverScreen(gameHasStarted: gameHasStarted),
                      MyBarrier(
                        barrierx: barrierx[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierx: barrierx[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarrier: true,
                      ),
                      MyBarrier(
                        barrierx: barrierx[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarrier: false,
                      ),
                      MyBarrier(
                        barrierx: barrierx[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarrier: true,
                      ),
                      Container(
                        alignment: const Alignment(0, -0.5),
                        child: const Text(
                          'TAP TO PLAY',
                           style: TextStyle(
                           color: Colors.white,
                           fontSize: 30,
                          fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

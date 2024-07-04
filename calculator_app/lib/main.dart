import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String text = '0';
  double n1 = 0;
  double n2 = 0;
  dynamic result = '';
  dynamic final_result = '0';
  dynamic opr = '';
  dynamic preOpr = '';

  Widget calButton(String btntext, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        Calculation(btntext);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: btncolor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        btntext,
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  void Calculation(String btntext) {
    if (btntext == 'AC') {
      text = '0';
      n1 = 0;
      n2 = 0;
      result = '';
      final_result = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btntext == '=') {
      if (preOpr == '+') {
        final_result = add();
      } else if (preOpr == '-') {
        final_result = sub();
      } else if (preOpr == 'x') {
        final_result = mul();
      } else if (preOpr == '/') {
        final_result = div();
      }
    } else if (btntext == '+' || btntext == '-' || btntext == 'x' || btntext == '/' || btntext == '=') {
      if (result.isNotEmpty) {
        if (n1 == 0) {
          n1 = double.parse(result);
        } else {
          n2 = double.parse(result);
        }
      }

      if (opr == '+') {
        final_result = add();
      } else if (opr == '-') {
        final_result = sub();
      } else if (opr == 'x') {
        final_result = mul();
      } else if (opr == '/') {
        final_result = div();
      }
      preOpr = opr;
      opr = btntext;
      result = '';
    } else if (btntext == '%') {
      result = (n1 / 100).toString();
      final_result = doesContainDecimal(result);
    } else if (btntext == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      final_result = result;
    } else {
      result = result + btntext;
      final_result = result;
    }

    setState(() {
      text = final_result;
    });
  }

  String add() {
    result = (n1 + n2).toString();
    n1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (n1 - n2).toString();
    n1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (n1 * n2).toString();
    n1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (n1 / n2).toString();
    n1 = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) return result = splitDecimal[0].toString();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          text,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white, fontSize: 100),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('AC', Colors.grey, Colors.black),
                calButton('+/-', Colors.grey, Colors.black),
                calButton('%', Colors.grey, Colors.black),
                calButton('/', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('7', Colors.grey, Colors.white),
                calButton('8', Colors.grey, Colors.white),
                calButton('9', Colors.grey, Colors.white),
                calButton('x', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('4', Colors.grey, Colors.white),
                calButton('5', Colors.grey, Colors.white),
                calButton('6', Colors.grey, Colors.white),
                calButton('-', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calButton('1', Colors.grey, Colors.white),
                calButton('2', Colors.grey, Colors.white),
                calButton('3', Colors.grey, Colors.white),
                calButton('+', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Calculation('0');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.fromLTRB(30, 20, 120, 20),
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ),
                calButton('.', Colors.grey, Colors.black),
                calButton('=', Colors.orange, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

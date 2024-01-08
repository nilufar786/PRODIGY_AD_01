import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _expressionController = TextEditingController();
  String _expression = '';
  String _result = '';

  void _appendToExpression(String value) {
    setState(() {
      _expression += value;
      _expressionController.text = _expression;
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
      _result = '';
      _expressionController.clear();
    });
  }

  void _calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      double result = exp.evaluate(EvaluationType.REAL, ContextModel());

      setState(() {
        _result = '$_expression = $result';
        _expression = result.toString();
        _expressionController.text = _expression;
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Girls Calculator',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent),)),
      ),
      body: Container(
        color: Colors.pinkAccent.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,

          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _result,
                style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildButton('C'),
                _buildButton('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (buttonText == '=') {
              _calculate();
            } else if (buttonText == 'C') {
              _clear();
            } else {
              _appendToExpression(buttonText);
            }
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24,color: Colors.pinkAccent),
          ),
        ),
      ),
    );
  }
}

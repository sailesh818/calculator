import 'package:flutter/material.dart';

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _input = '';
  String _result = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        try {
          _result = _evaluate(_input).toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  double _evaluate(String expr) {
    // VERY basic eval: only handles + - * /
    List<String> tokens = expr
        .split(RegExp(r'([+\-*/])'))
        .map((e) => e.trim())
        .toList();
    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double num = double.parse(tokens[i + 1]);

      switch (op) {
        case '+':
          result += num;
          break;
        case '-':
          result -= num;
          break;
        case '*':
          result *= num;
          break;
        case '/':
          result /= num;
          break;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_input, style: TextStyle(fontSize: 32)),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ...buttons.map(
            (row) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: row.map((btn) {
                return ElevatedButton(
                  onPressed: () => _buttonPressed(btn),
                  child: Text(btn, style: TextStyle(fontSize: 24)),
                  style: ElevatedButton.styleFrom(fixedSize: Size(70, 70)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

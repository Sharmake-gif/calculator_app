import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "";
  double? _num1;
  double? _num2;
  String? _operator;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "clear") {
        _input = "";
        _output = "";
        _num1 = null;
        _num2 = null;
        _operator = null;
      } else if (value == "=") {
        if (_num1 != null && _operator != null && _input.isNotEmpty) {
          _num2 = double.tryParse(_input);
          if (_num2 == null) return;

          switch (_operator) {
            case "+":
              _output = (_num1! + _num2!).toString();
              break;
            case "-":
              _output = (_num1! - _num2!).toString();
              break;
            case "*":
              _output = (_num1! * _num2!).toString();
              break;
            case "/":
              _output = (_num2 == 0) ? "Error" : (_num1! / _num2!).toString();
              break;
          }
          _input = _output;
          _num1 = null;
          _num2 = null;
          _operator = null;
        }
      } else if (["+", "-", "*", "/"].contains(value)) {
        if (_input.isNotEmpty) {
          _num1 = double.tryParse(_input);
          _operator = value;
          _input = "";
        }
      } else {
        _input += value;
      }
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Sharmake's Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _input.isEmpty ? _output : _input,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              for (var row in [
                ["1", "2", "3", "4", "5"],
                ["6", "7", "8", "9", "0"],
                ["clear", "*", "/", "-", "=", "+"],
              ])
                Row(
                  children: row.map((text) => _buildButton(text)).toList(),
                )
            ],
          ),
        ],
      ),
    );
  }
}

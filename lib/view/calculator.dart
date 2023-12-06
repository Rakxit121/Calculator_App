import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _clear();
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "/") {
        num1 = double.parse(_output);
        operand = buttonText;
        _output = "0";
      } else if (buttonText == "=") {
        num2 = double.parse(_output);
        _calculate();
      } else if (buttonText == "del") {
        _deleteLastInput();
      } else if (buttonText == "%") {
        _convertToPercent();
      } else {
        _output = (_output == "0") ? buttonText : _output + buttonText;
      }
    });
  }

  void _clear() {
    _output = "0";
    num1 = 0.0;
    num2 = 0.0;
    operand = "";
  }

  void _calculate() {
    switch (operand) {
      case "+":
        _output = (num1 + num2).toString();
        break;
      case "-":
        _output = (num1 - num2).toString();
        break;
      case "*":
        _output = (num1 * num2).toString();
        break;
      case "/":
        _output = (num1 / num2).toString();
        break;
      default:
        break;
    }
    num1 = double.parse(_output);
    operand = "";
  }

  void _deleteLastInput() {
    setState(() {
      _output =
          _output.length > 1 ? _output.substring(0, _output.length - 1) : "0";
    });
  }

  void _convertToPercent() {
    setState(() {
      double currentValue = double.parse(_output);
      _output = (currentValue / 100).toString();
    });
  }

  Widget _buildButton(String buttonText, {bool isDouble = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[200],
            padding: const EdgeInsets.all(24.0),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator App",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: _output),
              style: const TextStyle(fontSize: 32.0),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.all(16.0),
              ),
            ),
          ),
          // const Divider(),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    _buildButton("C"),
                    _buildButton("*"),
                    _buildButton("/"),
                    _buildButton("del"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("+"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("-"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("*"),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("%"),
                    _buildButton("0"),
                    _buildButton(".", isDouble: true),
                    _buildButton("="),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

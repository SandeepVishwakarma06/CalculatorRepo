// ignore_for_file: prefer_const_constructors, deprecated_member_use, sort_child_properties_last

import 'package:calculator_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    ),
  );
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = "";
  var output = "";
  var operation = "";
  var hideInput = false;
  var oututSize = 34.0;
  onButtonClick(value) {
    //if value is AC
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "\u232b") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("×", "*");
        userInput = input.replaceAll("÷", "/");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        oututSize = 52.0;
      }
    } else {
      input = input + value;
      hideInput = false;
      oututSize = 34.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: oututSize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )),

            // Buttons Area
            Row(
              children: [
                button(
                    text: "AC",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
                button(
                    text: "\u232b",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
                button(
                    text: "%",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
                button(
                    text: "÷",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(
                    text: "×",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(
                    text: "-",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(
                    text: "+",
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(text: "00"),
                button(text: "0"),
                button(text: "."),
                button(text: "=", buttonBgColor: orangeColor),
              ],
            )
          ],
        ));
  }

  Widget button({text, textColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22),
              primary: buttonBgColor),
        ),
      ),
    );
  }
}

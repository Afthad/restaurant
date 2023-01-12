import 'package:flutter/material.dart';
import 'package:get/get.dart';



Widget textWidget({
  required String text,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 14,
  Color color = Colors.black,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
  );
}
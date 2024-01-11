import 'dart:ui';
import 'package:flutter/material.dart';

// grid dimension
int rowLength = 10;
int colLength = 15;

enum TypeOfBlock {
  L,
  J,
  I,
  O,
  S,
  Z,
  T,
}

enum Direction {
  left,
  right,
  down,
}

const Map <TypeOfBlock, Color> BlockColors = {
  TypeOfBlock.L : Colors.cyan,
  TypeOfBlock.J : Colors.blueAccent,
  TypeOfBlock.I : Colors.deepOrangeAccent,
  TypeOfBlock.O : Colors.amber,
  TypeOfBlock.S : Colors.purple,
  TypeOfBlock.Z : Colors.teal,
  TypeOfBlock.T : Colors.deepPurpleAccent,
};
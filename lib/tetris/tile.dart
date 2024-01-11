import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  var color;
  var child;
  Tile({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(1),
      child: Center(child: Text(child.toString(), style: TextStyle(color: Colors.transparent),),),
    );
  }
}
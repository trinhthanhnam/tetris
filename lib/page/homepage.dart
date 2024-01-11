import "package:flutter/material.dart";
import 'package:tetris_match/tetris/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Tetris Lego Demo"),
      ),
      body: Center(
        child: Text("Click the Red button below to join the simple game!"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationHomepage.currentState?.pushNamed('/game');
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.red,
      ),
    );
  }
}

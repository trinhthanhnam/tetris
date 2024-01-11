import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:tetris_match/tetris/main.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final messageReceive = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Board")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text("This is notification text receive:"),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(messageReceive.notification!.title.toString()),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(messageReceive.notification!.body.toString()),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(messageReceive.data.toString()),
          ),
          Align(
            alignment: Alignment.center,
            child: Text("Click the button in bottom for entering game"),
          ),
        ],
      ),
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

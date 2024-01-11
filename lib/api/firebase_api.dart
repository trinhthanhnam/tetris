import 'package:firebase_messaging/firebase_messaging.dart';
import "package:tetris_match/tetris/main.dart";

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(message == null) {
    return;
  }
  print("firebaseMessagingBackgroundHandler called!");
}

class FireBaseApi {
  // create an instant of FireBase Messaging
  final _fireBaseMessaging = FirebaseMessaging.instance;
  // function for init messaging
  Future<void> initNotification() async {
    // request permission from user
    await _fireBaseMessaging.requestPermission();
    // fetch FCM token for this device, whatever user allow permission or not
    final fFCMToken = await _fireBaseMessaging.getToken();
    // print to token for verify, everytime app installed on device then a new token is created
    print("FireBase connect succesfully! This device token is: " + fFCMToken.toString());
    // attach notifition on this device
    attachPushNotification();
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  // function for handle messages
  void handleMessage(RemoteMessage? message) {
    if(message == null) {
      return;
    }
    navigationHomepage.currentState?.pushNamed('/notification', arguments: message);
  }
  // function for foreground and background settings
  Future attachPushNotification() async {
    // if app closed then open now
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // attach listener for open app when notification come
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
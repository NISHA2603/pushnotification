import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final  _firebaseMessaging = FirebaseMessaging.instance ;
  // void firebaseCloudMessaging_Listeners() {
  //   // if (Platform.isIOS) iOS_Permission();
  //
  //   _firebaseMessaging.getToken().then((token){
  //     print(token);
  //   });
  //   _firebaseMessaging
  //   // _firebaseMessaging.configure(
  //   //   onMessage: (Map<String, dynamic> message) async {
  //   //     print('on message $message');
  //   //   },
  //   //   onResume: (Map<String, dynamic> message) async {
  //   //     print('on resume $message');
  //   //   },
  //   //   onLaunch: (Map<String, dynamic> message) async {
  //   //     print('on launch $message');
  //   //   },
  //   // );
  // }

  @override
  Future<void> initStat {
    // TODO: implement initState
    super.initState();
    // firebaseCloudMessaging_Listeners();
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getToken().then((value) {
      print("=================================== > "+value.toString());
    });

    // FirebaseMessaging.instance.getInitialMessage().then(
    //   (message) {
    //     print("======= FirebaseMessaging.instance.getInitialMessage");
    //     print("======= $message");
    //     if (message != null) {
    //       print("New Notification");
    //       // if (message.data['_id'] != null) {
    //       //   Navigator.of(context).push(
    //       //     MaterialPageRoute(
    //       //       builder: (context) => DemoScreen(
    //       //         id: message.data['_id'],
    //       //       ),
    //       //     ),
    //       //   );
    //       // }
    //     }
    //   },
    // );
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // // 2. This method only call when App in forground it mean app must be opened
    // FirebaseMessaging.onMessage.listen(
    //   (message) {
    //     print("========= FirebaseMessaging.onMessage.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data11 ${message.data}");
    //       // LocalNotificationService.display(message);
    //
    //     }
    //   },

    // );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    // // 3. This method only call when App in background and not terminated(not closed)
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //   (message) {
    //     print("======= FirebaseMessaging.onMessageOpenedApp.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       print("message.data22 ${message.data['_id']}");
    //     }
    //   },
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification App"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Push Notification"),
      ),
    );
  }
}

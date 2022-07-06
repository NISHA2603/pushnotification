// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//
//   // final  _firebaseMessaging = FirebaseMessaging.instance ;
//   // void firebaseCloudMessaging_Listeners() {
//   //   _firebaseMessaging.getToken().then((token){
//   //     print(token);
//   //   });
//   //   _firebaseMessaging;
//   //
//   // }
//
//   @override
//   // void initStat() async {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   // firebaseCloudMessaging_Listeners();
//   //   // 1. This method call when app in terminated state and you get a notification
//   //   // when you click on notification app open from terminated state and you can get notification data in this method
//   //   FirebaseMessaging.instance.getToken().then((value) {
//   //     print("=================================== > " + value.toString());
//   //   });
//   //
//   //   // FirebaseMessaging.instance.getInitialMessage().then(
//   //   //   (message) {
//   //   //     print("======= FirebaseMessaging.instance.getInitialMessage");
//   //   //     print("======= $message");
//   //   //     if (message != null) {
//   //   //       print("New Notification");
//   //   //       // if (message.data['_id'] != null) {
//   //   //       //   Navigator.of(context).push(
//   //   //       //     MaterialPageRoute(
//   //   //       //       builder: (context) => DemoScreen(
//   //   //       //         id: message.data['_id'],
//   //   //       //       ),
//   //   //       //     ),
//   //   //       //   );
//   //   //       // }
//   //   //     }
//   //   //   },
//   //   // );
//   //   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   //   NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     announcement: false,
//   //     badge: true,
//   //     carPlay: false,
//   //     criticalAlert: false,
//   //     provisional: false,
//   //     sound: true,
//   //   );
//   //   print('==========User granted permission: ${settings.authorizationStatus}');
//   //
//   //   // // 2. This method only call when App in forground it mean app must be opened
//   //   // FirebaseMessaging.onMessage.listen(
//   //   //   (message) {
//   //   //     print("========= FirebaseMessaging.onMessage.listen");
//   //   //     if (message.notification != null) {
//   //   //       print(message.notification!.title);
//   //   //       print(message.notification!.body);
//   //   //       print("message.data11 ${message.data}");
//   //   //       // LocalNotificationService.display(message);
//   //   //
//   //   //     }
//   //   //   },
//   //
//   //   // );
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//   //     print('Got a message whilst in the foreground!');
//   //     print('Message data: ${message.data}');
//   //
//   //     if (message.notification != null) {
//   //       print('=============Message also contained a notification: ${message.notification}');
//   //     }
//   //   });
//   //   // // 3. This method only call when App in background and not terminated(not closed)
//   //   // FirebaseMessaging.onMessageOpenedApp.listen(
//   //   //   (message) {
//   //   //     print("======= FirebaseMessaging.onMessageOpenedApp.listen");
//   //   //     if (message.notification != null) {
//   //   //       print(message.notification!.title);
//   //   //       print(message.notification!.body);
//   //   //       print("message.data22 ${message.data['_id']}");
//   //   //     }
//   //   //   },
//   //   // );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notification App"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text("Push Notification"),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../streams/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notificationTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              notificationBody,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              notificationData,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learn/home.dart';
import 'package:learn/mainn.dart';
import 'package:learn/loginpages/newuser.dart';
import 'package:learn/phone.dart';
import 'package:learn/verify.dart';
import 'package:learn/main_common.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCd3AhDQXlc3ag29UhOchatxTznzhgLQdQ',
      appId: '1:274892453914:android:ef1aa229cf6955e7bd79a3',
      messagingSenderId: '274892453914',
      projectId: 'learn-7187a',
    ),) :
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'homepage' : (context) => Myuser()
    },
  ));
}

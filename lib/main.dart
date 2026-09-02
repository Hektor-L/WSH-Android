import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workservicehub_project/views/splash1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: CupertinoColors.activeBlue, selectedItemColor: CupertinoColors.white, unselectedItemColor: CupertinoColors.inactiveGray),
        appBarTheme: AppBarTheme(backgroundColor: CupertinoColors.activeBlue, foregroundColor: CupertinoColors.black),
      ),
      title: 'WorkServiceHub',
      home: Splash1(),
    );
  }
}
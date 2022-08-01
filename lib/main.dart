import 'package:flutter/material.dart';
import 'package:weather/screens/home/home.dart';
import 'package:weather/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: getThemeData(),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

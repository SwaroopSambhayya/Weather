import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/screens/home/home.dart';
import 'package:weather/screens/onboarding/onboarding.dart';
import 'package:weather/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MyApp(prefs: prefs),
  );
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool? onboarded = false;

  @override
  void initState() {
    super.initState();
    getHome();
  }

  getHome() async {
    onboarded = widget.prefs.getBool("onboarded");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Weather',
      theme: getThemeData(),
      debugShowCheckedModeBanner: false,
      home: onboarded != null && onboarded! ? const Home() : const OnBoarding(),
    );
  }
}

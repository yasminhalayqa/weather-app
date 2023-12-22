import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:weather_app/views/onboarding_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences preferences;
  late String userCity = '';
  bool showOnboarding = true;

  @override
  void initState() {
    super.initState();
    _checkIsFirstTime();
  }

  Future<void> _checkIsFirstTime() async {
    preferences = await SharedPreferences.getInstance();
    bool isFirstTime = preferences.get('userCity') == null;

    setState(() {
      showOnboarding = isFirstTime;
      userCity = preferences.getString('userCity') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFf07867),
          primary: Color(0xFFf07867),
        ),
        useMaterial3: true,
      ),
      home: showOnboarding ? const OnBoardingScreen() : const HomeScreen(),
    );
  }
}

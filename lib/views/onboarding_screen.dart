import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/data.dart';
import 'package:weather_app/constants/styles.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/home_screen.dart';

String selectPlaceholder = 'Select City';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  String dropdownValue = selectPlaceholder;
  late SharedPreferences pref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/weather.png'),
              const SizedBox(height: 32),
              const Text(
                'Welcome to the Weather App!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Please select your current city',
                style: TextStyle(fontSize: 16, color: Colors.black38),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                // when the user select new city update the status using the wearther provider and set 
                //rebuild to reflect the new selected city in the application 
                onChanged: (String? cityValue) {
                  Provider.of<WeatherProvider>(context, listen: false).setCityName(cityValue!);
                  setState(() {
                    dropdownValue = cityValue;
                  });
                },
                items: [selectPlaceholder, ...cities]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    enabled: value != selectPlaceholder,
                    child: Text(
                      value,
                      style: value == selectPlaceholder
                          ? const TextStyle(color: Colors.black38)
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: dropdownValue == selectPlaceholder
                      ? null
                      : () {
                          Provider.of<WeatherProvider>(context, listen: false)
                              .setCityName(dropdownValue);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                  style: dropdownValue == selectPlaceholder
                      ? disabledCTAButtonStyle
                      : enabledCTAButtonStyle,
                  child: const Text('Go To Homepage'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

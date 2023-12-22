import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/constants/styles.dart';
import 'package:weather_app/models/city_current_weather.dart';
import 'package:weather_app/models/weather_api_response.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences preferences;
  late Future<CityCurrentWeatherModel> cityCurrentWeatherData;
  late Future<WeatherApiResponse> cityData;

  // Future<WeatherApiResponse> getCityWeather() async {
  //   preferences = await SharedPreferences.getInstance();
  //   final userCity = preferences.get('userCity');
  //   WeatherApiResponse data;
  //   final response = await http.get(Uri.parse(
  //       "https://api.weatherapi.com/v1/forecast.json?key=101eaa9e29d54da8b7362102230712&q=$userCity&days=7&api=no"));
  //   if (response.statusCode == 200) {
  //     var jsonObject = jsonDecode(response.body);
  //     data = WeatherApiResponse.fromJson(jsonObject);
  //   } else {
  //     throw Exception("Failed to load weather data for $userCity");
  //   }
  //   return data;
  // }

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<WeatherProvider>(context, listen: false);
    cityData = provider.getCityWeather().then((cityData) {
      provider.setForecastData(cityData.forecast);
      provider.setHourlyData(cityData.forecast.forecastday[0].hour);
      return cityData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Weather App"),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: FutureBuilder(
        future: cityData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var cityData = snapshot.data as WeatherApiResponse;
            var cityWeatherData = CityCurrentWeatherModel(
              cityName: cityData.location.name,
              iconUrl: 'https:${cityData.currentWeather.condition.icon}',
              condition: cityData.currentWeather.condition.text,
              tempC: cityData.currentWeather.tempC,
            );
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cityWeatherData.cityName,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Image.network(cityWeatherData.iconUrl),
                  const SizedBox(height: 8),
                  Text(
                    '${cityWeatherData.tempC} °C',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cityWeatherData.condition,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            print('-----${snapshot.error}');
            return const Center(
              child: Text(
                "Error Occurred",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

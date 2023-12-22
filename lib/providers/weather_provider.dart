import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/models/weather_api_response.dart';
import 'package:http/http.dart' as http;

class WeatherProvider extends ChangeNotifier {
  String userCityName = '';
  late ForecastModel forecastData = ForecastModel(forecastday: []);
  List<HourData> hourlyData = [];
  late SharedPreferences pref;


  void initializeCityNameFromPrefs() async {
    pref = await SharedPreferences.getInstance();
    userCityName = pref.getString('userCity') ?? '';
    notifyListeners();
  }

  void setCityName(String city) {
    userCityName = city;
    notifyListeners();
  }

  void setForecastData(ForecastModel forecastData) {
    this.forecastData = forecastData;
    notifyListeners();
  }

  void setHourlyData(List<HourData> hourlyData) {
    this.hourlyData = hourlyData;
    notifyListeners();
  }

  Future<WeatherApiResponse> getCityWeather({String? cityName}) async {
    var selectedCity = userCityName;
    print('cityName $cityName');
    if (cityName != null) {
      selectedCity = cityName;
    }
    print('selected city ${selectedCity}');
    WeatherApiResponse data;
    final response = await http.get(Uri.parse(
        "https://api.weatherapi.com/v1/forecast.json?key=101eaa9e29d54da8b7362102230712&q=$selectedCity&days=7&api=no"));
    if (response.statusCode == 200) {
      var jsonObject = jsonDecode(response.body);
      data = WeatherApiResponse.fromJson(jsonObject);
    } else {
      throw Exception("Failed to load weather data for $selectedCity");
    }
    return data;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/views/drawer.dart';
import 'package:weather_app/views/place_card.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late Future<List<WeatherModel>> futureWeatherList;

  Future<List<WeatherModel>> getWeatherList() async {
    List<WeatherModel> weatherList = [];
    for (String city in cities) {
      final response = await http.get(Uri.parse(
          "https://api.weatherapi.com/v1/forecast.json?key=101eaa9e29d54da8b7362102230712&q=$city&days=7&api=no"));
      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        WeatherModel data = WeatherModel.fromJson(jsonObject);
        weatherList.add(data);
      } else {
        throw Exception("Failed to load weather data for $city");
      }
    }

    return weatherList;
  }

  @override
  void initState() {
    super.initState();
    futureWeatherList = getWeatherList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text('Places')),
      body: FutureBuilder(
        future: futureWeatherList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<WeatherModel> data = snapshot.data as List<WeatherModel>;
            return GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                data.length,
                (index) {
                  return PlaceCard(weather: data[index]);
                },
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("No data available."),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

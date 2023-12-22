import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/styles.dart';
import 'package:weather_app/models/weather_api_response.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/drawer.dart';

class ForecastPage extends StatefulWidget {
  ForecastPage({super.key, this.cityName});
  String? cityName;
  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<ForecastModel> cityDailyForecastData;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<WeatherProvider>(context, listen: false);
    cityDailyForecastData =
        provider.getCityWeather(cityName: widget.cityName).then((cityData) {
      return cityData.forecast;
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
          future: cityDailyForecastData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as ForecastModel;
              return ListView.builder(
                itemCount: data.forecastday.length,
                itemBuilder: (context, index) {
                  final dayData = data.forecastday[index];
                  return ListTile(
                    title: Text('Day: ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Max Temperature: ${dayData.day.maxtemp_c}°C'),
                        Text('Min Temperature: ${dayData.day.mintemp_c}°C'),
                      ],
                    ),
                    leading: Image.network(
                      'https:${dayData.day.condition.icon}',
                      width: 50,
                      height: 50,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error occured',
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/styles.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/providers/weather_provider.dart';

import 'package:weather_app/views/drawer.dart';

class HourlyPage extends StatefulWidget {
  HourlyPage({super.key, this.cityName});
  String? cityName;

  @override
  State<HourlyPage> createState() => _HourlyPageState();
}

class _HourlyPageState extends State<HourlyPage> {
  late Future<List<HourData>> hourlyData;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<WeatherProvider>(context, listen: false);
    hourlyData = provider.getCityWeather(cityName: widget.cityName).then((cityData) {
      return cityData.forecast.forecastday[0].hour;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Hourly Forecast"),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: FutureBuilder(
        future: hourlyData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var hourlyData = snapshot.data as List<HourData>;
            return ListView.builder(
              itemCount: hourlyData.length,
              itemBuilder: (context, index) {
                final hourData = hourlyData[index];
                return ListTile(
                  title: Text('Time: ${hourData.time}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperature: ${hourData.temp_c}°C'),
                      Text('Condition: ${hourData.condition.text}'),
                    ],
                  ),
                  leading: Image.network(
                    'https:${hourData.condition.icon}',
                    width: 50,
                    height: 50,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error occurred',
                style: TextStyle(color: Colors.redAccent),
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

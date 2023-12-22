import 'package:flutter/material.dart';
import 'package:weather_app/views/daily_forecast_screen.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:weather_app/views/places_screen.dart';
import 'package:weather_app/views/hourly_forecast_screen.dart';

enum Tab { home, hourlyForecast, places, dailyForecast }

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text(''),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Hourly Forecast'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HourlyPage(),
                  ));
            },
          ),
          ListTile(
            title: const Text('Daily Forecast'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForecastPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Places'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlacesScreen(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

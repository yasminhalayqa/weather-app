import 'package:weather_app/models/weather.dart';

class WeatherApiResponse {
  final Location location;
  final CurrentWeather currentWeather;
  final ForecastModel forecast;

  WeatherApiResponse({
    required this.location,
    required this.currentWeather,
    required this.forecast,
  });
  factory WeatherApiResponse.fromJson(Map<String, dynamic> json) {
    return WeatherApiResponse(
      location: Location.fromJson(json['location']),
      currentWeather: CurrentWeather.fromJson(json['current']),
      forecast: ForecastModel.fromJson(json['forecast']),
    );
  }
}

class ForecastModel {
  final List<ForecastData> forecastday;
  ForecastModel({required this.forecastday});

  factory ForecastModel.fromJson(dynamic json) {
    var forecastList = json['forecastday'] as List<dynamic>;
    List<ForecastData> dataList =
        forecastList.map((e) => ForecastData.fromJson(e)).toList();
    return ForecastModel(forecastday: dataList);
  }
}

class Location {
  final String name;
  Location({required this.name});

  factory Location.fromJson(dynamic json) {
    return Location(name: json['name']);
  }
}

class ForecastData {
  String date;
  DayData day;
  List<HourData> hour;

  ForecastData({
    required this.date,
    required this.day,
    required this.hour,
  });

  factory ForecastData.fromJson(dynamic json) {
    var hourList = json['hour'] as List<dynamic>;

    List<HourData> hourDataList =
        hourList.map((item) => HourData.fromJson(item)).toList();

    return ForecastData(
      date: json['date'],
      day: DayData.fromJson(json['day']),
      hour: hourDataList,
    );
  }
}

class DayData {
  double maxtemp_c;
  double mintemp_c;
  double avgtemp_c;
  double maxwind_mph;
  double totalprecip_mm;
  WetherCondition condition;

  DayData({
    required this.maxtemp_c,
    required this.mintemp_c,
    required this.avgtemp_c,
    required this.maxwind_mph,
    required this.totalprecip_mm,
    required this.condition,
  });

  factory DayData.fromJson(dynamic json) {
    return DayData(
      maxtemp_c: json['maxtemp_c'],
      mintemp_c: json['mintemp_c'],
      avgtemp_c: json['avgtemp_c'],
      maxwind_mph: json['maxwind_mph'],
      totalprecip_mm: json['totalprecip_mm'],
      condition: WetherCondition.fromJson(json['condition']),
    );
  }
}

class CurrentWeather {
  final double tempC;
  final double tempF;
  final WeatherCondition condition;

  CurrentWeather({
    required this.tempC,
    required this.tempF,
    required this.condition,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      condition: WeatherCondition.fromJson(json['condition']),
    );
  }
}

class WeatherCondition {
  final String text;
  final String icon;
  final int code;

  WeatherCondition({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}

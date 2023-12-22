class WeatherModel {
  String name;
  String temp_c;
  WetherCondition condition;
  List<ForecastData> forecastData;

  WeatherModel({
    required this.name,
    required this.temp_c,
    required this.condition,
    required this.forecastData,
  });

  factory WeatherModel.fromJson(dynamic json) {
    var forecastList = json['forecast']['forecastday'] as List<dynamic>;
    List<ForecastData> forecastData =
        forecastList.map((item) => ForecastData.fromJson(item)).toList();

    return WeatherModel(
      name: json['location']['name'],
      temp_c: json['current']['temp_c'].toString(),
      forecastData: forecastData,
      condition: WetherCondition.fromJson(json['current']['condition']),
    );
  }
}

class WetherCondition {
  String text;
  String icon;
  String code;

  WetherCondition({
    required this.code,
    required this.icon,
    required this.text,
  });

  factory WetherCondition.fromJson(Map<String, dynamic> json) {
    return WetherCondition(
      code: json['code'].toString(),
      icon: json['icon'],
      text: json['text'],
    );
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

class HourData {
  String time;
  double temp_c;
  WetherCondition condition;

  HourData({
    required this.time,
    required this.temp_c,
    required this.condition,
  });

  factory HourData.fromJson(dynamic json) {
    return HourData(
      time: json['time'],
      temp_c: json['temp_c'],
      condition: WetherCondition.fromJson(json['condition']),
    );
  }
}

class CityCurrentWeatherModel {
  final String cityName;
  final String iconUrl;
  final double tempC;
  final String condition;

  CityCurrentWeatherModel({
    required this.cityName,
    required this.iconUrl,
    required this.tempC,
    required this.condition,
  });

  factory CityCurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CityCurrentWeatherModel(
      cityName: json['cityName'],
      iconUrl: json['iconUrl'],
      tempC: json['temp_c'],
      condition: json['condition'],
    );
  }
}

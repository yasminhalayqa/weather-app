import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:weather_app/models/city.dart';

class CityDatabase {
  late Database _database;

  Future<void> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cities.db');

    _database = await openDatabase(path, version: 1, onCreate: ((db, version) {
      return db
          .execute('CREATE TABLE cities(id INTEGER PRIMARY KEY, name TEXT)');
    }));
  }

  Future<void> insertCity(CityModel city) async {
    await _database.insert('cities', {'name': city.cityName});
  }

  Future<List<CityModel>> getCities() async {
    final List<Map<String, dynamic>> maps = await _database.query('cities');

    return List.generate(maps.length, (i) {
      return CityModel(cityName: maps[i]['name']);
    });
  }
}

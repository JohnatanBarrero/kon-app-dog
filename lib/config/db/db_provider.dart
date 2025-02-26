import 'dart:convert';
import 'dart:io';

import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'DogDB.db');
    // Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE Dogs(
         id INTEGER PRIMARY KEY,
        body TEXT 
      )
    ''');
    });
  }

  Future<void> cleanTableDogs() async {
    final db = await database;
    //Eliminamos los registros anteriores para no duplicar
    await db!.delete('Dogs');
  }

  Future<int> newListDogs(String dogsListText) async {
    final db = await database;

    final res = await db!.insert('Dogs', <String, Object?>{'body': dogsListText});
    // Es el ID del último registro insertado;
    return res;
  }

  Future<List<DogModel>> getLastDogs() async {
    final db = await database;
    final res = await db!.query('Dogs', columns: ['body']);

    if (res.isEmpty) {
      return [];
    } else {
      List<DogModel> directions = [];
      for (var item in res) {
        final decodedBody = json.decode(item['body'].toString());
        directions.add(DogModel.fromJson(decodedBody));
      }
      return directions;
    }
  }
}

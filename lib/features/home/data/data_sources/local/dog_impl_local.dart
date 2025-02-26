import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:konfio_app_dog/config/db/db_provider.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/local/abstract_dog_local.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:konfio_app_dog/shared/utils/json_loader.dart';

class DogImplLocal extends AbstractDogLocal {
  @override
  Future<List<DogModel>> getDogsLocal() async {
    try {
      final response = await DBProvider.db.getLastDogs();
      return response;
    } catch (e) {
      // Como el enpoint que trae los dogs aveces no jala entonces se carga de un archivo local
      try {
        final JsonLoader jsonLoader = JsonLoader('assets/data/dogdata.json');

        // Cargar los datos JSON
        final dynamic jsonData = await jsonLoader.cargarDatosJson();
        if (jsonData != null) {
          await jsonLoader.verificarCrearYLLenarArchivo(jsonData, 'dogdata');
          final dynamic infoDogs =
              await jsonLoader.leerDatosDesdeArchivo('dogdata');
          List<DogModel> ltsDogs = (infoDogs)
              .map<DogModel>((element) => DogModel.fromJson(element))
              .toList();
          return ltsDogs;
        }
      } catch (e) {
        throw FlutterError('No se encontró ningún Dog');
      }
      throw FlutterError('No se encontró ningún Dog');
    }
  }

  @override
  Future<bool> saveLtsDogs(List<DogModel> ltsDogs) async {
    String jsonDogs = jsonEncode(ltsDogs.map((dog) => dog.toJson()).toList());
    final isSaved = await DBProvider.db.newListDogs(jsonDogs);
    return isSaved == 0 ? false : true;
  }
}

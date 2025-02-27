import 'package:flutter/material.dart';
import 'package:konfio_app_dog/config/api/api.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/remote/abstract_dog_api.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:konfio_app_dog/shared/utils/json_loader.dart';

class DogImplApi extends AbstractDogApi {
  final Api api;
  final JsonLoader jsonLoader;

  // Constructor que permite inyectar dependencias
  DogImplApi({
    required this.api,
    required this.jsonLoader,
  });

  @override
  Future<List<DogModel>> getDogs() async {
    try {
      final response = await api.getApi('1151549092634943488')
          .timeout(const Duration(seconds: 3));

      final dogs = response.data
          .map<DogModel>((element) => DogModel.fromJson(element))
          .toList();
      return dogs ?? [];
    } catch (e) {
      // Cargar datos locales si la API falla
      try {
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
}

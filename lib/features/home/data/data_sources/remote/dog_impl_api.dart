import 'package:flutter/material.dart';
import 'package:konfio_app_dog/config/api/api.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/remote/abstract_dog_api.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';

class DogImplApi extends AbstractDogApi {
  DogImplApi();

  @override
  Future<List<DogModel>> getDogs() async {
    // Crear una instancia de JsonLoader con la ruta del archivo JSON
    try {
      final response = await Api.getApi('1151549092634943488');

      final dogs = response.data
              .map<DogModel>((element) => DogModel.fromJson(element))
              .toList() ??
          [];
      return dogs;
    } catch (e) {
      throw FlutterError(
          'No se encontró ningún usuario con las credenciales proporcionadas.');
    }
  }
}

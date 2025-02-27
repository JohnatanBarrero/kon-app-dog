import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:konfio_app_dog/config/api/api.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/remote/dog_impl_api.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:konfio_app_dog/shared/utils/json_loader.dart';

// Anotación para generar los mocks
@GenerateMocks([Api, JsonLoader])
import 'dog_impl_api_test.mocks.dart';

void main() {
  late DogImplApi dogImplApi;
  late MockApi mockApi;
  late MockJsonLoader mockJsonLoader;

  setUp(() {
    mockApi = MockApi();
    mockJsonLoader = MockJsonLoader();
    dogImplApi = DogImplApi(api: mockApi, jsonLoader: mockJsonLoader);
  });

  test('getDogs devuelve una lista de perros desde la API', () async {
    // Simular respuesta de la API con datos estructurados correctamente
    final mockResponse = Response(
      data: [
        {
          'dogName': 'Rex',
          'description': 'Un perro amigable',
          'image': 'https://example.com/rex.jpg',
          'age': 3
        },
        {
          'dogName': 'Bobby',
          'description': 'Le encanta jugar',
          'image': 'https://example.com/bobby.jpg',
          'age': 2
        },
      ],
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    when(mockApi.getApi(any)).thenAnswer((_) async => mockResponse);

    final dogs = await dogImplApi.getDogs();

    expect(dogs, isA<List<DogModel>>());
    expect(dogs.length, 2);
    expect(dogs.first.dogName, 'Rex');
    expect(dogs.first.description, 'Un perro amigable');
    expect(dogs.first.image, 'https://example.com/rex.jpg');
    expect(dogs.first.age, 3);
  });

  test('getDogs usa datos locales si la API falla', () async {
    when(mockApi.getApi(any)).thenThrow(Exception('Error de red'));

    final mockLocalData = [
      {
        'dogName': 'Luna',
        'description': 'Muy cariñosa',
        'image': 'https://example.com/luna.jpg',
        'age': 4
      },
      {
        'dogName': 'Max',
        'description': 'Ama correr',
        'image': 'https://example.com/max.jpg',
        'age': 5
      },
    ];

    when(mockJsonLoader.cargarDatosJson()).thenAnswer((_) async => mockLocalData);
    when(mockJsonLoader.verificarCrearYLLenarArchivo(any, any))
        .thenAnswer((_) async => {});
    when(mockJsonLoader.leerDatosDesdeArchivo(any))
        .thenAnswer((_) async => mockLocalData);

    final dogs = await dogImplApi.getDogs();

    expect(dogs, isA<List<DogModel>>());
    expect(dogs.length, 2);
    expect(dogs.first.dogName, 'Luna');
    expect(dogs.first.description, 'Muy cariñosa');
    expect(dogs.first.image, 'https://example.com/luna.jpg');
    expect(dogs.first.age, 4);
  });

  test('getDogs lanza FlutterError si no hay datos disponibles', () async {
    when(mockApi.getApi(any)).thenThrow(Exception('Error de red'));
    when(mockJsonLoader.cargarDatosJson()).thenThrow(Exception('Archivo no encontrado'));

    expect(
      () async => await dogImplApi.getDogs(),
      throwsA(isA<FlutterError>()),
    );
  });
}

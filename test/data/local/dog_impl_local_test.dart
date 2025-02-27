
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfio_app_dog/config/db/db_provider.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/local/dog_impl_local.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:konfio_app_dog/shared/utils/json_loader.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generamos mocks para las dependencias
@GenerateMocks([DBProvider, JsonLoader])
import 'dog_impl_local_test.mocks.dart';

void main() {
  late DogImplLocal dogImplLocal;
  late MockDBProvider mockDBProvider;
  late MockJsonLoader mockJsonLoader;

  final testDogs = [
    const DogModel(
      dogName: 'Rex',
      description: 'Un perro amigable',
      image: 'https://example.com/rex.jpg',
      age: 3,
    ),
    const DogModel(
      dogName: 'Luna',
      description: 'Una perra juguetona',
      image: 'https://example.com/luna.jpg',
      age: 2,
    ),
  ];

  final testDogsJson = testDogs.map((dog) => dog.toJson()).toList();

  setUp(() {
    mockDBProvider = MockDBProvider();
    mockJsonLoader = MockJsonLoader();

    dogImplLocal = DogImplLocal(
      dbProvider: mockDBProvider,
      jsonLoader: mockJsonLoader,
    );
  });

  group('getDogsLocal', () {
    test('debería devolver perros desde la base de datos cuando está disponible', () async {
      when(mockDBProvider.getLastDogs()).thenAnswer((_) async => testDogs);

      final result = await dogImplLocal.getDogsLocal();

      expect(result, equals(testDogs));
      verify(mockDBProvider.getLastDogs()).called(1);
      verifyNever(mockJsonLoader.cargarDatosJson());
    });

    test('debería cargar desde archivo JSON cuando la base de datos falla', () async {
      when(mockDBProvider.getLastDogs()).thenThrow(Exception('Error de base de datos'));
      when(mockJsonLoader.cargarDatosJson()).thenAnswer((_) async => testDogsJson);
      when(mockJsonLoader.verificarCrearYLLenarArchivo(any, 'dogdata')).thenAnswer((_) async => true);
      when(mockJsonLoader.leerDatosDesdeArchivo('dogdata')).thenAnswer((_) async => testDogsJson);

      final result = await dogImplLocal.getDogsLocal();

      expect(result.length, equals(testDogs.length));

      verifyInOrder([
        mockDBProvider.getLastDogs(),
        mockJsonLoader.cargarDatosJson(),
        mockJsonLoader.verificarCrearYLLenarArchivo(any, 'dogdata'),
        mockJsonLoader.leerDatosDesdeArchivo('dogdata'),
      ]);
    });

    test('debería lanzar FlutterError cuando no hay datos disponibles', () async {
      when(mockDBProvider.getLastDogs()).thenThrow(Exception('Error de base de datos'));
      when(mockJsonLoader.cargarDatosJson()).thenThrow(Exception('Error al cargar JSON'));

      expect(
        () async => await dogImplLocal.getDogsLocal(),
        throwsA(isA<FlutterError>().having(
          (e) => e.message,
          'mensaje de error',
          'No se encontró ningún Dog',
        )),
      );
    });
  });

  group('saveLtsDogs', () {
    test('debería guardar correctamente los perros en la base de datos', () async {
      when(mockDBProvider.newListDogs(any)).thenAnswer((_) async => 1);

      final result = await dogImplLocal.saveLtsDogs(testDogs);

      expect(result, isTrue);
      verify(mockDBProvider.newListDogs(any)).called(1);
    });

    test('debería devolver false cuando falla al guardar en la base de datos', () async {
      when(mockDBProvider.newListDogs(any)).thenAnswer((_) async => 0);

      final result = await dogImplLocal.saveLtsDogs(testDogs);

      expect(result, isFalse);
      verify(mockDBProvider.newListDogs(any)).called(1);
    });
  });
}

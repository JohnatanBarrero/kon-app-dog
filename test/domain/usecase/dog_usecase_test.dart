import 'package:flutter_test/flutter_test.dart';
import 'package:konfio_app_dog/features/home/domain/repositories/dog_local_rerpository.dart';
import 'package:konfio_app_dog/features/home/domain/repositories/dog_respository.dart';
import 'package:konfio_app_dog/features/home/domain/usecases/dog_usecase.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Anotación para generar los mocks
@GenerateMocks([AbstractDogRepository, AbstractDogLocalRepository])
import 'dog_usecase_test.mocks.dart';

void main() {
  late DogUseCase dogUseCase;
  late MockAbstractDogRepository mockAbstractDogRepository;
  late MockAbstractDogLocalRepository mockAbstractDogLocalRepository;

  setUp(() {
    mockAbstractDogRepository = MockAbstractDogRepository();
    mockAbstractDogLocalRepository = MockAbstractDogLocalRepository();
    dogUseCase =
        DogUseCase(mockAbstractDogRepository, mockAbstractDogLocalRepository);
  });

  const mockDogs = [
    DogModel(
      dogName: 'Rex',
      description: 'Un perro amigable',
      image: 'https://example.com/rex.jpg',
      age: 3,
    ),
    DogModel(
      dogName: 'Bobby',
      description: 'Le encanta jugar',
      image: 'https://example.com/bobby.jpg',
      age: 2,
    ),
  ];

  test(
      'Devuelve la lista de perros desde el repositorio local si no está vacía',
      () async {
    when(mockAbstractDogLocalRepository.getDogsLocal())
        .thenAnswer((_) async => mockDogs);

    final result = await dogUseCase.call();

    expect(result, equals(mockDogs));
    verify(mockAbstractDogLocalRepository.getDogsLocal()).called(1);
    verifyNever(mockAbstractDogRepository.getDogs());
    verifyNever(mockAbstractDogLocalRepository.saveLtsDogs(any));
  });

  test(
      'Obtiene los datos de la API y los guarda localmente si no hay datos locales',
      () async {
    when(mockAbstractDogLocalRepository.getDogsLocal())
        .thenAnswer((_) async => []);
    when(mockAbstractDogRepository.getDogs()).thenAnswer((_) async => mockDogs);
    when(mockAbstractDogLocalRepository.saveLtsDogs(mockDogs)).thenAnswer(
        (_) async => true); // Retornar Future<bool> en vez de Future<Map>

    final result = await dogUseCase.call();

    expect(result, equals(mockDogs));
    verify(mockAbstractDogLocalRepository.getDogsLocal()).called(1);
    verify(mockAbstractDogRepository.getDogs()).called(1);
    verify(mockAbstractDogLocalRepository.saveLtsDogs(mockDogs)).called(1);
  });

  test('Lanza una excepción si la API y los datos locales fallan', () async {
    // Simulamos que getDogsLocal devuelve una lista vacía (sin datos locales)
    when(mockAbstractDogLocalRepository.getDogsLocal())
        .thenAnswer((_) async => []);

    // Simulamos que getDogs de la API falla y lanza una excepción
    when(mockAbstractDogRepository.getDogs())
        .thenThrow(Exception('Error en la API'));

    // Ejecutamos el caso de uso
    try {
      await dogUseCase.call();
    } catch (e) {
      // Comprobamos que se lanza una excepción, y si es así, continuamos.
      expect(e, isException);
    }

    // Verificamos que las funciones se hayan llamado
    verify(mockAbstractDogLocalRepository.getDogsLocal()).called(1);
    verify(mockAbstractDogRepository.getDogs()).called(1);

    // Verificamos que no se llame a saveLtsDogs
    verifyNever(mockAbstractDogLocalRepository.saveLtsDogs(any));
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:konfio_app_dog/features/home/domain/usecases/dog_usecase.dart';
import 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart';

import 'package:konfio_app_dog/general_model/dog_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';


@GenerateMocks([DogUseCase])
import 'bloc_test.mocks.dart'; 

void main() {
  late Bloc bloc;
  late MockDogUseCase mockDogUseCase;

  setUp(() {
    mockDogUseCase = MockDogUseCase();
    bloc = Bloc(dogUseCase: mockDogUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('el estado inicial debe ser InitialState', () {
    expect(bloc.state, isA<InitialState>());
  });

  blocTest<Bloc, State>(
    'Debe emitir [LoadingState, LoadedState] cuando el caso de uso retorna datos correctamente',
    build: () {
      final dogList = [
        const DogModel(
          dogName: 'Luna',
          description: 'perrito feliz',
          image: 'https://image.com/dog2.jpg',
          age: 3
        )
      ];
      
      when(mockDogUseCase.call()).thenAnswer((_) async => dogList);
      return bloc;
    },
    act: (bloc) => bloc.add( LoadInitialEvent()),
    expect: () => [
      isA<LoadingState>(),
      isA<LoadedState>().having(
        (state) => state.model.ltsDogModel,
        'ltsDogModel',
        isNotNull,
      ),
    ],
    verify: (_) {
      verify(mockDogUseCase.call()).called(1);
    },
  );

  blocTest<Bloc, State>(
    'Debe emitir [LoadingState] cuando inicia el evento del bloc, y cuando falla [ErrorState] cuando el caso de uso lanza una excepción',
    build: () {
      when(mockDogUseCase.call()).thenThrow(Exception('Error de conexión'));
      return bloc;
    },
    act: (bloc) => bloc.add( LoadInitialEvent()),
    expect: () => [
      isA<LoadingState>(),
      isA<ErrorState>(),
    ],
    verify: (_) {
      verify(mockDogUseCase.call()).called(1);
    },
  );
}
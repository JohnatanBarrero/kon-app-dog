// Mocks generated by Mockito 5.4.4 from annotations
// in konfio_app_dog/test/data/local/dog_impl_local_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:konfio_app_dog/config/db/db_provider.dart' as _i3;
import 'package:konfio_app_dog/general_model/dog_model.dart' as _i5;
import 'package:konfio_app_dog/shared/utils/json_loader.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabase_0 extends _i1.SmartFake implements _i2.Database {
  _FakeDatabase_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DBProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockDBProvider extends _i1.Mock implements _i3.DBProvider {
  MockDBProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Database?> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _i4.Future<_i2.Database?>.value(),
      ) as _i4.Future<_i2.Database?>);

  @override
  _i4.Future<_i2.Database> initDB() => (super.noSuchMethod(
        Invocation.method(
          #initDB,
          [],
        ),
        returnValue: _i4.Future<_i2.Database>.value(_FakeDatabase_0(
          this,
          Invocation.method(
            #initDB,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Database>);

  @override
  _i4.Future<void> cleanTableDogs() => (super.noSuchMethod(
        Invocation.method(
          #cleanTableDogs,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<int> newListDogs(String? dogsListText) => (super.noSuchMethod(
        Invocation.method(
          #newListDogs,
          [dogsListText],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);

  @override
  _i4.Future<List<_i5.DogModel>> getLastDogs() => (super.noSuchMethod(
        Invocation.method(
          #getLastDogs,
          [],
        ),
        returnValue: _i4.Future<List<_i5.DogModel>>.value(<_i5.DogModel>[]),
      ) as _i4.Future<List<_i5.DogModel>>);
}

/// A class which mocks [JsonLoader].
///
/// See the documentation for Mockito's code generation for more information.
class MockJsonLoader extends _i1.Mock implements _i6.JsonLoader {
  MockJsonLoader() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<dynamic> cargarDatosJson() => (super.noSuchMethod(
        Invocation.method(
          #cargarDatosJson,
          [],
        ),
        returnValue: _i4.Future<dynamic>.value(),
      ) as _i4.Future<dynamic>);

  @override
  _i4.Future<void> guardarDatosJson(
    List<dynamic>? jsonData,
    String? path,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #guardarDatosJson,
          [
            jsonData,
            path,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> verificarCrearYLLenarArchivo(
    List<dynamic>? jsonData,
    String? path,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #verificarCrearYLLenarArchivo,
          [
            jsonData,
            path,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<dynamic>> leerDatosDesdeArchivo(String? path) =>
      (super.noSuchMethod(
        Invocation.method(
          #leerDatosDesdeArchivo,
          [path],
        ),
        returnValue: _i4.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i4.Future<List<dynamic>>);
}

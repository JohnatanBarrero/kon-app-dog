import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class JsonLoader {
  final String _filePath;

  JsonLoader(this._filePath);

  Future<dynamic> cargarDatosJson() async {
    try {
      // Obtener la referencia al archivo JSON desde los activos
      final jsonString = await rootBundle.loadString(_filePath);

      // Decodificar el JSON
      final dynamic data = json.decode(jsonString);

      return data;
    } catch (e) {
      // Manejar errores aquí, como la imposibilidad de cargar el archivo o el formato JSON incorrecto
      debugPrint('Error al cargar el archivo de json');
      return null;
    }
  }

  Future<void> guardarDatosJson(List<dynamic> jsonData, String path) async {
    try {
      // Obtiene el directorio de documentos de la aplicación
      final Directory documentsDir = await getApplicationDocumentsDirectory();
      final String filePath = '${documentsDir.path}/$path.json';

      // Guarda los datos en el archivo
      final File file = File(filePath);
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      // Manejar errores aquí, como la imposibilidad de cargar el archivo o el formato JSON incorrecto
      debugPrint('Error al guardar el archivo de json');
      throw 'Error al guardar el archivo de json';
    }
  }

  Future<void> verificarCrearYLLenarArchivo(List<dynamic> jsonData, String path) async {
    try {
      // Obtiene el directorio de documentos de la aplicación
      final Directory documentsDir = await getApplicationDocumentsDirectory();
      final String filePath = '${documentsDir.path}/$path.json';

      // Verifica si el archivo ya existe
      final bool exists = await File(filePath).exists();

      if (!exists) {
        // Si el archivo no existe, lo crea con contenido inicial
        final File file = File(filePath);
       

        await file.writeAsString(json.encode(jsonData));

        debugPrint('Archivo creado en: $filePath');
      } else {
        debugPrint('El archivo ya existe en: $filePath');
      }
    } catch (e) {
      debugPrint('Error al verificar y crear el archivo: $e');
    }
  }
   Future<List<dynamic>> leerDatosDesdeArchivo(String path) async {
    try {
      // Obtiene el directorio de documentos de la aplicación
      final Directory documentsDir = await getApplicationDocumentsDirectory();
      final String filePath = '${documentsDir.path}/$path.json';

      // Verifica si el archivo existe
      final bool exists = await File(filePath).exists();

      if (exists) {
        // Lee los datos del archivo
        final File file = File(filePath);
        final String fileContents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(fileContents);

        debugPrint('Datos leídos desde el archivo: $jsonData');
        return jsonData;
      } else {
        debugPrint('El archivo no existe en la ruta especificada.');
        return [];
      }
    } catch (e) {
      debugPrint('Error al leer datos desde el archivo: $e');
      return [];
    }
  }
}

#!/bin/bash

# Verificación de argumentos
if [ $# -eq 0 ]; then
    echo "Usage: $0 <feature_name>"
    exit 1
fi

# Nombre de la nueva feature
FEATURE_NAME=$1

#Nombre de la nueva feature en primera letra mayúscula
FEATURE_NAME_MAYUS=$(echo ${FEATURE_NAME} | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')


# Directorio raíz del proyecto
PROJECT_DIR="./"

# Crear la estructura de carpetas clean arquitecture
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/remote"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/local"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/repositories"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/models"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/repositories"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/usecases"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/controllers"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/pages"
mkdir -p "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/widgets"


# Crear archivos base 
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/local/abs_${FEATURE_NAME}_dts_local.dart"
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/local/imp_${FEATURE_NAME}_dts_local.dart"


# Crear archivos base y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/remote/abs_${FEATURE_NAME}_dts_remote.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/remote/abs_${FEATURE_NAME}_dts_remote.dart"
import '../../../domain/models/${FEATURE_NAME}_model.dart';

abstract class Abstract${FEATURE_NAME_MAYUS}DataSourceRemote {
   Future<${FEATURE_NAME_MAYUS}Model> get${FEATURE_NAME_MAYUS}();
}
EOF

# Crear archivos base y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/remote/imp_${FEATURE_NAME}_dts_remote.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/data_source/remote/imp_${FEATURE_NAME}_dts_remote.dart"
import '../../../domain/models/${FEATURE_NAME}_model.dart';
import '../../../data/data_source/remote/abs_${FEATURE_NAME}_dts_remote.dart';
import '../../../../../../config/data_source/prixz_api.dart';
import 'package:konfio_app_dog/config/data_source/prixz_api_mixin_bk.dart';
import 'package:konfio_app_dog/config/data_source/prixz_api_mixin_mc.dart';

class Implement${FEATURE_NAME_MAYUS}DataSourceRemote extends Abstract${FEATURE_NAME_MAYUS}DataSourceRemote with PrixzApiMixinbk , PrixzApiMixinMc {
  @override
  Future<${FEATURE_NAME_MAYUS}Model> get${FEATURE_NAME_MAYUS}() async {

    final response = await PrixzApi.get('api/current.json');

    final ${FEATURE_NAME}Response =${FEATURE_NAME_MAYUS}Model.fromJson(response.data);

    return ${FEATURE_NAME}Response;
  }
}
EOF

# Crear y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/repositories/imp_${FEATURE_NAME}_dts_repository.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/data/repositories/imp_${FEATURE_NAME}_dts_repository.dart"
import '../../domain/repositories/abs_${FEATURE_NAME}_dmn_repository.dart';
import '../../domain/models/${FEATURE_NAME}_model.dart';
import '../data_source/remote/imp_${FEATURE_NAME}_dts_remote.dart';


class Implement${FEATURE_NAME_MAYUS}DataSourceRepository extends  Abstract${FEATURE_NAME_MAYUS}DomainRepository {

 final Implement${FEATURE_NAME_MAYUS}DataSourceRemote implement${FEATURE_NAME_MAYUS}DataSourceRemote;

  Implement${FEATURE_NAME_MAYUS}DataSourceRepository(
    this.implement${FEATURE_NAME_MAYUS}DataSourceRemote,
  );

  @override
  Future<${FEATURE_NAME_MAYUS}Model> get${FEATURE_NAME_MAYUS}() async {

    return await implement${FEATURE_NAME_MAYUS}DataSourceRemote.get${FEATURE_NAME_MAYUS}();
  
  }
}
EOF

# Crear y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/repositories/abs_${FEATURE_NAME}_dmn_repository.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/repositories/abs_${FEATURE_NAME}_dmn_repository.dart"
import '../models/${FEATURE_NAME}_model.dart';


abstract class Abstract${FEATURE_NAME_MAYUS}DomainRepository  {

    Future<${FEATURE_NAME_MAYUS}Model> get${FEATURE_NAME_MAYUS}();
}
EOF

# Crear y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/usecases/${FEATURE_NAME}_usecase.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/usecases/${FEATURE_NAME}_usecase.dart"
import '../models/${FEATURE_NAME}_model.dart';
import '../repositories/abs_${FEATURE_NAME}_dmn_repository.dart';


 class ${FEATURE_NAME_MAYUS}UseCase {
    final Abstract${FEATURE_NAME_MAYUS}DomainRepository abstract${FEATURE_NAME_MAYUS}DomainRepository;  

    ${FEATURE_NAME_MAYUS}UseCase(this.abstract${FEATURE_NAME_MAYUS}DomainRepository);


    Future<${FEATURE_NAME_MAYUS}Model> get${FEATURE_NAME_MAYUS}() async {
      return await abstract${FEATURE_NAME_MAYUS}DomainRepository.get${FEATURE_NAME_MAYUS}();
    }
  
}
EOF

# Crear y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/controllers/${FEATURE_NAME}_controller.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/controllers/${FEATURE_NAME}_controller.dart"

import 'package:get/get.dart';
import '../../domain/models/${FEATURE_NAME}_model.dart';
import '../../domain/usecases/${FEATURE_NAME}_usecase.dart';


class ${FEATURE_NAME_MAYUS}Controller extends GetxController {
 
  final ${FEATURE_NAME_MAYUS}UseCase ${FEATURE_NAME}UseCase;

  ${FEATURE_NAME_MAYUS}Controller(this.${FEATURE_NAME}UseCase);

  final _${FEATURE_NAME} = ${FEATURE_NAME_MAYUS}Model(holabebe: '').obs;
  set ${FEATURE_NAME}(${FEATURE_NAME_MAYUS}Model value) => _${FEATURE_NAME}.value = value;
  ${FEATURE_NAME_MAYUS}Model get ${FEATURE_NAME} => _${FEATURE_NAME}.value;

  @override
  void onInit() {
    super.onInit();
    get${FEATURE_NAME_MAYUS}();
  }

  Future<void> get${FEATURE_NAME_MAYUS}() async {
    final ${FEATURE_NAME_MAYUS}Model = await ${FEATURE_NAME}UseCase.get${FEATURE_NAME_MAYUS}();
    ${FEATURE_NAME} = ${FEATURE_NAME_MAYUS}Model;
  }
}
EOF

# Crear y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/pages/${FEATURE_NAME}_page.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/pages/${FEATURE_NAME}_page.dart"

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:konfio_app_dog/features/widget_general/container_screen.dart';
import '../widgets/${FEATURE_NAME}_widget.dart';

class ${FEATURE_NAME_MAYUS}Page extends StatelessWidget {
  const ${FEATURE_NAME_MAYUS}Page({super.key});

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ContainerScreenPrixz(
              child: ${FEATURE_NAME_MAYUS}Widget()
            ),
          ),
        ),
      ),
    );
  }
}

EOF
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/widgets/${FEATURE_NAME}_widget.dart"
# Crear y escribir código en los archivos
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/presentacion/widgets/${FEATURE_NAME}_widget.dart"


import 'package:flutter/material.dart';

class ${FEATURE_NAME_MAYUS}Widget extends StatelessWidget {
  const ${FEATURE_NAME_MAYUS}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('Hola bebe que mas pues'),),);
  }
}

EOF

# Crear y escribir código en los archivos
touch "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/models/${FEATURE_NAME}_model.dart"
cat <<EOF > "$PROJECT_DIR/lib/features/$FEATURE_NAME/domain/models/${FEATURE_NAME}_model.dart"


class ${FEATURE_NAME_MAYUS}Model {
   final String holabebe;
    ${FEATURE_NAME_MAYUS}Model({
    required this.holabebe,
  });
  ${FEATURE_NAME_MAYUS}Model copyWith({
    String? holabebe,
  }) =>
      ${FEATURE_NAME_MAYUS}Model(
        holabebe: holabebe ?? this.holabebe,
      );

  factory ${FEATURE_NAME_MAYUS}Model.fromJson(Map<String, dynamic> json) => ${FEATURE_NAME_MAYUS}Model(
        holabebe: json['holabebe'],
      );

  Map<String, dynamic> toJson() => {
        'holabebe': holabebe,
      };
}
EOF

dart format .
# Imprimir mensaje de éxito
echo "Feature '$FEATURE_NAME' created successfully, si no quedo bien entonces hagalo usted ajhjahjh"

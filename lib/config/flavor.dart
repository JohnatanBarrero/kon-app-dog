import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

int kIsDev = 3;

abstract class FlavorKeys {
  static const mainUrl = 'mainUrl';
  static const textToEnv = 'textToEnv';
}

extension FlavorConfigExtention on FlavorConfig {
  bool get isDev => name!.contains('DEVELOP');
  bool get isCert => name!.contains('CERTIFICATION');
  bool get isProd => name!.contains('PRODUCTION');

  String get mainUrl => variables[FlavorKeys.mainUrl];
  String get textToEnv => variables[FlavorKeys.textToEnv];
}

void setFlavorMX() {
  switch (kIsDev) {
    case 1:
      FlavorConfig(
          name: 'DEVELOP',
          location: BannerLocation.topEnd,
          variables: {
            FlavorKeys.mainUrl: 'https://jsonblob.com/api/',
            FlavorKeys.textToEnv: 'Desarrollo',
          });
      break;
    case 2:
      FlavorConfig(
          name: 'CERTIFICATION',
          location: BannerLocation.topEnd,
          variables: {
            FlavorKeys.mainUrl: 'https://jsonblob.com/api/',
            FlavorKeys.textToEnv: 'Certificación',
          });
      break;
    case 3:
      FlavorConfig(
        name: 'PRODUCTION',
        location: BannerLocation.topEnd,
        variables: {
          FlavorKeys.mainUrl: 'https://jsonblob.com/api/',
          FlavorKeys.textToEnv: 'Producción',
        },
      );

      break;
    default:
  }
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:konfio_app_dog/config/api/http_maganer.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/local/dog_impl_local.dart';
import 'package:konfio_app_dog/features/home/data/data_sources/remote/dog_impl_api.dart';
import 'package:konfio_app_dog/features/home/data/repositories/dog_local_impl.dart';
import 'package:konfio_app_dog/features/home/data/repositories/dog_respository_impl.dart';
import 'package:konfio_app_dog/features/home/domain/usecases/dog_usecase.dart';
import 'package:konfio_app_dog/features/home/presentation/pages/home_screen.dart'
    as home;
import 'package:konfio_app_dog/features/home/presentation/pages/splash_screen.dart';

//import 'api/raiser_http_maganer.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<HttpManager>(HttpManager.new);
    i.addSingleton(() => DogImplApi());
    i.addSingleton(() => DogImplLocal());
    i.addSingleton(() => DogRespositoryImpl(i.get<DogImplApi>()));
    i.addSingleton(() => DogLocalImpl(i.get<DogImplLocal>()));
    i.addSingleton(
        () => DogUseCase(i.get<DogRespositoryImpl>(), i.get<DogLocalImpl>()));
    i.addSingleton(() => home.Bloc(dogUseCase: Modular.get()));

    // //  i.add(XPTOEmail.new);
    // // i.add<EmailService>(XPTOEmailService.new);
    // // i.addSingleton(Client.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SplasScreen(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/Home',
      child: (context) => const home.HomeScreen(),
      transition: TransitionType.fadeIn,
    );
    // r.child(
    //   '/apoiments',
    //   child: (context) => const apoiments.Page(),
    //   transition: TransitionType.fadeIn,
    // );
    // r.child(
    //   '/attend',
    //   child: (context) => attend.Page(
    //     apoiment: r.args.data,
    //   ),
    //   transition: TransitionType.fadeIn,
    // );
    // r.child(
    //   '/finished',
    //   child: (context) => const finished.Page(),
    //   transition: TransitionType.fadeIn,
    // );
    // r.child(
    //   '/gps_page',
    //   child: (context) => const gps.GpsPageScreen(),
    //   transition: TransitionType.fadeIn,
    // );
  }
}

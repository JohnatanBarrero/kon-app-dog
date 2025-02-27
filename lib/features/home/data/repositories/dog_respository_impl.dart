import 'package:konfio_app_dog/features/home/data/data_sources/remote/dog_impl_api.dart';
import 'package:konfio_app_dog/features/home/domain/repositories/dog_respository.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';

class DogRespositoryImpl extends AbstractDogRepository {
  final DogImplApi dogApi;

  DogRespositoryImpl(
    this.dogApi,
  );

  @override
  Future<List<DogModel>> getDogs() async {
    return await dogApi.getDogs();
  }
}

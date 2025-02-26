import 'package:konfio_app_dog/features/home/data/data_sources/local/dog_impl_local.dart';
import 'package:konfio_app_dog/features/home/domain/repositories/dog_local_rerpository.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';

class DogLocalImpl extends AbstractDogLocalRepository {
  final DogImplLocal dogLocal;

  DogLocalImpl(
    this.dogLocal,
  );

  @override
  Future<bool> saveLtsDogs(List<DogModel> ltsDogs) async {
    return await dogLocal.saveLtsDogs(ltsDogs);
  }

  @override
  Future<List<DogModel>> getDogsLocal() async {
    return await dogLocal.getDogsLocal();
  }
}

import 'package:konfio_app_dog/general_model/dog_model.dart';

abstract class AbstractDogLocal {
  Future<List<DogModel>> getDogsLocal();
  Future<bool> saveLtsDogs(List<DogModel> ltsDogs);
}

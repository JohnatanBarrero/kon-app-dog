import 'package:konfio_app_dog/general_model/dog_model.dart';

abstract class AbstractDogLocalRepository {
  Future<List<DogModel>> getDogsLocal();
   Future<bool> saveLtsDogs(List<DogModel> ltsDogs);
}

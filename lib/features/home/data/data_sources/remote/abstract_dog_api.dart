import 'package:konfio_app_dog/general_model/dog_model.dart';

abstract class AbstractDogApi {
  Future<List<DogModel>> getDogs();
}

import 'package:konfio_app_dog/general_model/dog_model.dart';

abstract class AbstractDogRepository {
  Future<List<DogModel>> getDogs();
}

import 'package:konfio_app_dog/features/home/domain/repositories/dog_respository.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';

class DogUseCase {
  final AbstractDogRepository abstractDogRepository;

  DogUseCase(this.abstractDogRepository);
  Future<List<DogModel>> call() async {
    return await abstractDogRepository.getDogs();
  }
}

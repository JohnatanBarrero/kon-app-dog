import 'package:konfio_app_dog/features/home/domain/repositories/dog_local_rerpository.dart';
import 'package:konfio_app_dog/features/home/domain/repositories/dog_respository.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';

class DogUseCase {
  final AbstractDogRepository abstractDogRepository;
  final AbstractDogLocalRepository abstractDogLocalRepository;

  DogUseCase(this.abstractDogRepository, this.abstractDogLocalRepository);
  Future<List<DogModel>> call() async {
    final ltsLocalDogs = await abstractDogLocalRepository.getDogsLocal();
    if (ltsLocalDogs.isNotEmpty) {
      return ltsLocalDogs;
    } else {
      final ltsDogs = await abstractDogRepository.getDogs();
      await abstractDogLocalRepository.saveLtsDogs(ltsDogs);
      return ltsDogs;
    }
  }
}

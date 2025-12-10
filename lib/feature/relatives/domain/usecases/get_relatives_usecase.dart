// get_relatives_usecase.dart
import '../../data/models/relative_model.dart';
import '../repositories/relative_repository.dart';

class GetRelativesUseCase {
  final RelativeRepository repo;
  GetRelativesUseCase(this.repo);

  Future<List<RelativeModel>> call(String mainCccd) =>
      repo.getRelatives(mainCccd);
}

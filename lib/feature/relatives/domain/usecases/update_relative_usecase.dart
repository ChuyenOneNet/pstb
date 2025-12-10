// update_relative_usecase.dart
import '../../data/models/relative_model.dart';
import '../repositories/relative_repository.dart';

class UpdateRelativeUseCase {
  final RelativeRepository repo;
  UpdateRelativeUseCase(this.repo);

  Future<RelativeModel> call(String mainCccd, int id, RelativeModel model) =>
      repo.updateRelative(mainCccd, id, model);
}

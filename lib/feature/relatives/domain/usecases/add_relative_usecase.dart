// add_relative_usecase.dart
import '../../data/models/relative_model.dart';
import '../repositories/relative_repository.dart';

class AddRelativeUseCase {
  final RelativeRepository repo;
  AddRelativeUseCase(this.repo);

  Future<RelativeModel> call(String mainCccd, RelativeModel model) =>
      repo.addRelative(mainCccd, model);
}

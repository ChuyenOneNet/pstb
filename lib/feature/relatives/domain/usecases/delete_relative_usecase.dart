// delete_relative_usecase.dart
import '../repositories/relative_repository.dart';

class DeleteRelativeUseCase {
  final RelativeRepository repo;
  DeleteRelativeUseCase(this.repo);

  Future<void> call(String mainCccd, int id) =>
      repo.deleteRelative(mainCccd, id);
}

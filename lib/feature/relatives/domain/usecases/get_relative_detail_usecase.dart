// get_relative_detail_usecase.dart
import '../../data/models/relative_model.dart';
import '../repositories/relative_repository.dart';

class GetRelativeDetailUseCase {
  final RelativeRepository repo;
  GetRelativeDetailUseCase(this.repo);

  Future<RelativeModel> call(String mainCccd, int id) =>
      repo.getRelativeDetail(mainCccd, id);
}

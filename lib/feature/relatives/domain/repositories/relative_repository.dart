import '../../data/models/relative_model.dart';

abstract class RelativeRepository {
  Future<List<RelativeModel>> getRelatives(String mainCccd);
  Future<RelativeModel> getRelativeDetail(String mainCccd, int id);
  Future<RelativeModel> addRelative(String mainCccd, RelativeModel model);
  Future<RelativeModel> updateRelative(
    String mainCccd,
    int id,
    RelativeModel model,
  );
  Future<void> deleteRelative(String mainCccd, int id);
}

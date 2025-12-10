// import '../../domain/repositories/relative_repository.dart';
// import '../datasources/relative_remote_ds.dart';
// import '../models/relative_model.dart';
//
// class RelativeRepositoryImpl implements RelativeRepository {
//   final RelativeRemoteDataSource remote;
//
//   RelativeRepositoryImpl(this.remote);
//
//   @override
//   Future<List<RelativeModel>> getRelatives(String mainCccd) {
//     return remote.getRelatives(mainCccd);
//   }
//
//   @override
//   Future<RelativeModel> getRelativeDetail(String mainCccd, int id) {
//     return remote.getRelativeDetail(mainCccd, id);
//   }
//
//   @override
//   Future<RelativeModel> addRelative(
//       String mainCccd, RelativeModel model) async {
//     return remote.addRelative(mainCccd, model);
//   }
//
//   @override
//   Future<RelativeModel> updateRelative(
//       String mainCccd, int id, RelativeModel model) {
//     return remote.updateRelative(mainCccd, id, model);
//   }
//
//   @override
//   Future<void> deleteRelative(String mainCccd, int id) {
//     return remote.deleteRelative(mainCccd, id);
//   }
// }

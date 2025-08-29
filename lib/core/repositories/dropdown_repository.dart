import '../../models/address_model.dart';
import '../../models/ethnic_model.dart';
import '../../models/job_model.dart';
import '../../models/nationality_model.dart';
import '../services/dropdown_service.dart';

abstract class DropdownRepository {
  Future<List<Nationality>> fetchNationalities(String filter);
  Future<List<Job>> fetchJobs(String filter);
  Future<List<Ethnic>> fetchEthnics(String filter);
  Future<List<Address>> getAddresses(String filter, int type);
}

class DropdownRepositoryImpl implements DropdownRepository {
  final DropdownService service;

  DropdownRepositoryImpl(this.service);

  @override
  Future<List<Nationality>> fetchNationalities(String filter) async {
    final response = await service.getNationalities(filter);
    if (response.data != null) {
      return response.data!;
    }
    throw Exception("Failed to load nationalities");
  }

  @override
  Future<List<Job>> fetchJobs(String filter) async {
    final response = await service.getJobs(filter);
    if (response.data != null) {
      return response.data!;
    }
    throw Exception("Failed to load jobs");
  }

  @override
  Future<List<Ethnic>> fetchEthnics(String filter) async {
    final response = await service.getEthnics(filter);
    if (response.data != null) {
      return response.data!;
    }
    throw Exception("Failed to load ethnics");
  }

  @override
  Future<List<Address>> getAddresses(String filter, int type) async {
    final response = await service.fetchAddresses(filter, type);

    if (response.data != null) {
      return response.data!;
    }
    throw Exception("Failed to load ethnics");
  }
}

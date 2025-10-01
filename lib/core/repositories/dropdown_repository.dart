import '../../models/address_model.dart';
import '../../models/ethnic_model.dart';
import '../../models/job_model.dart';
import '../../models/nationality_model.dart';
import '../services/dropdown_service.dart';

abstract class DropdownRepository {
  Future<List<Nationality>> fetchNationalities(String filter);
  Future<List<Job>> fetchJobs(String filter);
  Future<List<Ethnic>> fetchEthnics(String filter);
  Future<List<Address>> getAddresses(Map<String, dynamic> body);
  Future<List<Address>> getCity(Map<String, dynamic> body);
}

class DropdownRepositoryImpl implements DropdownRepository {
  final DropdownService service;

  DropdownRepositoryImpl(this.service);

  @override
  Future<List<Nationality>> fetchNationalities(String filter) async {
    final response = await service.getNationalities({});
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
  Future<List<Address>> getAddresses(Map<String, dynamic> body) async {
    final response = await service.fetchAddresses(body);

    if (response.data != null) {
      return response.data!;
    }
    throw Exception("Failed to load ethnics");
  }

  @override
  Future<List<Address>> getCity(Map<String, dynamic> body) async {
    final response = await service.fetchCity(body);

    if (response.data != null) {
      return response.data!;
    }
    throw Exception("Failed to load ethnics");
  }
}

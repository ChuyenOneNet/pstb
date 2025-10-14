import 'package:pstb/models/treatment_catalog_model.dart';

import '../../models/address_model.dart';
import '../../models/ethnic_model.dart';
import '../../models/job_model.dart';
import '../../models/nationality_model.dart';
import '../../models/treatment_catalog_department_model.dart';
import '../services/dropdown_service.dart';

abstract class DropdownRepository {
  Future<List<Nationality>> fetchNationalities(String filter);
  Future<List<Job>> fetchJobs();
  Future<List<Ethnic>> fetchEthnics();
  Future<List<Address>> getAddresses(Map<String, dynamic> body);
  Future<List<Address>> getCity(Map<String, dynamic> body);
  Future<List<TreatmentCatalogModel>> fetchTreatmentCatalogs();
  Future<List<TreatmentCatalogDepartmentModel>>
      fetchTreatmentCatalogDepartments(String treatmentCatalogId);
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
  Future<List<Job>> fetchJobs() async {
    final response = await service.getJobs();
    return response;
    throw Exception("Failed to load jobs");
  }

  @override
  Future<List<Ethnic>> fetchEthnics() async {
    final response = await service.getEthnics();
    return response;
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

  @override
  Future<List<TreatmentCatalogModel>> fetchTreatmentCatalogs() async {
    final response = await service.fetchTreatmentCatalogs();

    return response;

    throw Exception("Failed to load ethnics");
  }

  @override
  Future<List<TreatmentCatalogDepartmentModel>>
      fetchTreatmentCatalogDepartments(String treatmentCatalogId) async {
    final response =
        await service.fetchfetchTreatmentCatalogDepartments(treatmentCatalogId);

    return response;

    throw Exception("Failed to load ethnics");
  }
}

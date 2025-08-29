import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:intl/intl.dart';

import '../../../utils/routes.dart';
import '../../../widgets/dropdown/dropdown.dart';

part 'perform_medicine_store.g.dart';

class PerformMedicineStore = _PerformMedicineStore with _$PerformMedicineStore;

abstract class _PerformMedicineStore with Store {
  final formKey = GlobalKey<FormState>();

  @observable
  DropdownData? selectedDepartment;

  @observable
  DropdownData? selectedRoom;

  @observable
  TextEditingController dateController = TextEditingController();

  @observable
  TextEditingController patientCodeController = TextEditingController();

  @action
  void setDepartment(DropdownData? data) {
    selectedDepartment = data;
  }

  @action
  void setRoom(DropdownData? data) {
    selectedRoom = data;
  }

  @action
  void setDate(DateTime date) {
    print(date);
    dateController.text = DateFormat('HH:mm dd/MM/yyyy').format(date);
  }

  // Giả sử async search API
  Future<List<DropdownData>> searchDepartments(String text) async {
    // TODO: Gọi API tìm khoa
    return [];
  }

  Future<List<DropdownData>> searchRooms(String text) async {
    // TODO: Gọi API tìm buồng
    return [];
  }

  void submit() {
    // TODO: Gọi API lưu thực hiện thuốc
    print('Đã xác nhận với mã bệnh nhân: ${patientCodeController.text}');
    Modular.to.pushNamed(
      AppRoutes.perFormMedicineOrderPage,
      arguments: {
        'patientCode': '2400234931',
        'patientInfo': 'BN: TUAN K4 - 35 tuổi - Nam',
        'executionDate': '15:00 27/06/2025',
      },
    );
  }
}

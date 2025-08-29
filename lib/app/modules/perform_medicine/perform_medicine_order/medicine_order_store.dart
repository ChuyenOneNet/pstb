import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import '../../../../utils/routes.dart';
import '../../../models/perform_medicine/medicine_order.dart';
import '../../../models/perform_medicine/medicine_usage_model.dart';

part 'medicine_order_store.g.dart';

class MedicineOrderStore = _MedicineOrderStore with _$MedicineOrderStore;

abstract class _MedicineOrderStore with Store {
  @observable
  ObservableList<MedicineOrder> orders = ObservableList<MedicineOrder>();

  @computed
  bool get isAllSelected =>
      orders.isNotEmpty && orders.every((o) => o.isSelected);

  @computed
  List<MedicineOrder> get selectedOrders =>
      orders.where((o) => o.isSelected).toList();

  @action
  void fetchOrders() {
    final data = [
      MedicineOrder(
          orderText: 'Y lệnh : 16:19 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 8.5,
          total: 16),
      MedicineOrder(
          orderText: 'Y lệnh : 09:29 22/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 3,
          total: 3),
      MedicineOrder(
          orderText: 'Y lệnh : 16:18 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 11,
          total: 11),
      MedicineOrder(
          orderText: 'Y lệnh : 16:16 18/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: -0.5,
          total: 8),
      MedicineOrder(
          orderText: 'Y lệnh : 16:19 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 8.5,
          total: 16),
      MedicineOrder(
          orderText: 'Y lệnh : 09:29 22/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 3,
          total: 3),
      MedicineOrder(
          orderText: 'Y lệnh : 16:18 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 11,
          total: 11),
      MedicineOrder(
          orderText: 'Y lệnh : 16:16 18/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: -0.5,
          total: 8),
      MedicineOrder(
          orderText: 'Y lệnh : 16:19 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 8.5,
          total: 16),
      MedicineOrder(
          orderText: 'Y lệnh : 09:29 22/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 3,
          total: 3),
      MedicineOrder(
          orderText: 'Y lệnh : 16:18 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 11,
          total: 11),
      MedicineOrder(
          orderText: 'Y lệnh : 16:16 18/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: -0.5,
          total: 8),
      MedicineOrder(
          orderText: 'Y lệnh : 16:19 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 8.5,
          total: 16),
      MedicineOrder(
          orderText: 'Y lệnh : 09:29 22/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 3,
          total: 3),
      MedicineOrder(
          orderText: 'Y lệnh : 16:18 19/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: 11,
          total: 11),
      MedicineOrder(
          orderText: 'Y lệnh : 16:16 18/06/2025 - BS: Nguyễn Ngọc Tuấn',
          available: -0.5,
          total: 8),
    ];
    orders = ObservableList.of(data);
    //Modular.to.pushNamed(AppRoutes.perFormMedicinePage);
  }

  @action
  Future<void> submitOrders() async {
    final selected = selectedOrders;

    if (selected.isEmpty) {
      Fluttertoast.showToast(msg: 'Không có y lệnh nào được chọn');
      print('Không có y lệnh nào được chọn.');
      return;
    }

    try {
      // Giả lập gọi API và tạo initialData
      await Future.delayed(const Duration(seconds: 1));
      print('Đã gửi ${selected.length} y lệnh thành công.');

      final fakeMedicines = selected.expand((order) {
        return List.generate(
            5,
            (index) => MedicineUsageModel(
                  medicineName: 'Thuốc ${order.orderText} - ${index + 1}',
                  description: 'Dùng cho ${order.orderText}',
                  wholeAmount: 0,
                  partialAmount: 0,
                  usageTime: DateTime.now(),
                ));
      }).toList();

      Modular.to.pushNamed(AppRoutes.performMedicineConfigPage, arguments: {
        'patientCode': 'BN0001',
        'patientInfo': 'Trần Văn A - 40 tuổi',
        'executionDate': '15:00 27/06/2025',
        'userName': 'Trần Trung Hiếu',
        'initialData': fakeMedicines,
      });
    } catch (e) {
      print('Lỗi khi gửi y lệnh: $e');
    }
  }

  @action
  void toggleItem(int index) {
    final current = orders[index];
    orders[index] = current.copyWith(isSelected: !current.isSelected);
  }

  @action
  void toggleAll() {
    final selectAll = !isAllSelected;
    orders =
        ObservableList.of(orders.map((e) => e.copyWith(isSelected: selectAll)));
  }
}

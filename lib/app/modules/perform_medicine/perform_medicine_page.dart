import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/perform_medicine/perform_medicine_store.dart';
import 'package:intl/intl.dart';

import '../../../utils/colors.dart';
import '../../../utils/routes.dart';
import '../../../utils/styles.dart';
import '../../../widgets/dropdown/dropdown_filter_with_label.dart';

class PerformMedicinePage extends StatelessWidget {
  final PerformMedicineStore store = PerformMedicineStore();

  PerformMedicinePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Modular.to.popAndPushNamed(AppRoutes.main),
            child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: const Text(
          'THỰC HIỆN THUỐC',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) => Form(
            key: store.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownFilterWithLabel(
                  selectedItem: store.selectedDepartment,
                  onChanged: (data) {
                    store.setDepartment(data);
                  },
                  hintText: 'Chọn khoa/phòng',
                  label: 'Khoa/Phòng *',
                  asyncItems: (text) => store.searchDepartments(text),
                  searchHintText: 'Nhập để tìm khoa/phòng',
                  validator: (data) => data == null ? 'Bắt buộc' : null,
                ),
                const SizedBox(height: 24),
                Text(
                  'Ngày thực hiện thuốc *',
                  style: Styles.style15grey.copyWith(
                    color: const Color(0xFF17181C),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: store.dateController,
                  decoration: const InputDecoration(
                    labelText: 'Ngày thực hiện thuốc ',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    // 1. Chọn ngày
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2023),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      // 2. Chọn giờ
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        // 3. Gộp lại thành 1 DateTime
                        final fullDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        // 4. Lưu lại và hiển thị định dạng
                        store.setDate(fullDateTime);
                        store.dateController.text =
                            DateFormat('dd/MM/yyyy HH:mm').format(fullDateTime);
                      }
                    }
                  },
                  readOnly: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Bắt buộc' : null,
                ),
                const SizedBox(height: 24),
                DropdownFilterWithLabel(
                  selectedItem: store.selectedRoom,
                  onChanged: (data) {
                    store.setRoom(data);
                  },
                  hintText: 'Chọn buồng bệnh',
                  label: 'Buồng bệnh *',
                  asyncItems: (text) => store.searchRooms(text),
                  searchHintText: 'Nhập để tìm buồng',
                  validator: (data) => data == null ? 'Bắt buộc' : null,
                ),
                const SizedBox(height: 24),
                Text(
                  'Mã Người bệnh *',
                  style: Styles.style15grey.copyWith(
                    color: const Color(0xFF17181C),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: store.patientCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Mã Người bệnh ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Bắt buộc' : null,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      store.submit();
                      // if (store.formKey.currentState?.validate() ?? false) {
                      //   store.submit();
                      // }
                    },
                    child: const Text(
                      'Xác nhận',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

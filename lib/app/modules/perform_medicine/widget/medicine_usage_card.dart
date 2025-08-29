import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/dropdown/dropdown.dart';
import '../../../../widgets/dropdown/dropdown_filter_with_label.dart';
import '../../../models/perform_medicine/medicine_usage_model.dart';
import '../medicine_usage/medicine_usage_store.dart';

class MedicineUsageCard extends StatelessWidget {
  final String executionDate;
  final int index;
  final MedicineUsageModel usage;
  final MedicineUsageStore store;

  const MedicineUsageCard({
    Key? key,
    required this.index,
    required this.usage,
    required this.store,
    required this.executionDate,
  });

  @override
  Widget build(BuildContext context) {
    String formatted;
    try {
      final date = DateFormat('HH:mm dd/MM/yyyy').parse(executionDate);
      formatted = DateFormat('HH:mm dd/MM/yyyy').format(date);
    } catch (_) {
      formatted = executionDate;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            usage.medicineName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // Text(usage.description),
          const SizedBox(height: 8),

          /// Dropdown số lượng nguyên
          DropdownFilterWithLabel(
            showSearchBox: false,
            label: 'Số lượng nguyên',
            hintText: 'Chọn số lượng nguyên',
            searchHintText: 'Tìm số lượng...',
            selectedItem: DropdownData(
              id: usage.wholeAmount.toInt().toString(),
              displayName: usage.wholeAmount.toInt().toString(),
            ),
            onChanged: (data) {
              final value = double.tryParse(data?.id ?? '0') ?? 0;
              store.updateWholeAmount(index, value);
            },
            asyncItems: (_) async => List.generate(
              101,
              (i) => DropdownData(id: i.toString(), displayName: i.toString()),
            ),
          ),

          /// Dropdown phần lẻ
          DropdownFilterWithLabel(
            showSearchBox: false,
            label: 'Phần lẻ',
            hintText: 'Chọn phần lẻ',
            searchHintText: 'Tìm phần lẻ...',
            selectedItem: DropdownData(
              id: usage.partialAmount.toStringAsFixed(2),
              displayName: usage.partialAmount.toStringAsFixed(2),
            ),
            onChanged: (data) {
              final value = double.tryParse(data?.id ?? '0') ?? 0;
              store.updatePartialAmount(index, value);
            },
            asyncItems: (_) async => List.generate(
              20,
              (i) {
                final value = (i * 0.05).toStringAsFixed(2);
                return DropdownData(id: value, displayName: value);
              },
            ),
          ),
          const SizedBox(height: 8),

          /// Tổng SL thực dụng
          Observer(
            builder: (_) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.surfaceLight,
              ),
              child: Text(
                'SL thực dùng: ${usage.totalUsed.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(height: 8),

          /// Thời gian sử dụng
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thời gian',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.surfaceLight,
                ),
                child: Text(
                  formatted,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Các checkbox
          Observer(
              builder: (_) => Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _buildCheckbox(
                              label: 'Trước ăn',
                              value: usage.beforeMeal,
                              onChanged: (val) =>
                                  store.toggleBeforeMeal(index, val),
                            ),
                            _buildCheckbox(
                              label: 'Sau ăn',
                              value: usage.afterMeal,
                              onChanged: (val) =>
                                  store.toggleAfterMeal(index, val),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _buildCheckbox(
                              label: 'Diễn biến',
                              value: usage.hasProgress,
                              onChanged: (val) =>
                                  store.toggleHasProgress(index, val),
                            ),
                            _buildCheckbox(
                              label: 'Khác',
                              value: usage.isOther,
                              onChanged: (val) =>
                                  store.toggleIsOther(index, val),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
        ],
      ),
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return CheckboxListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      value: value,
      onChanged: (val) => onChanged(val ?? false),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:pstb/utils/colors.dart';

class MedicalVisitFilterBar extends StatefulWidget {
  final Future<void> Function(DateTime? from, DateTime? to) onSearch;

  const MedicalVisitFilterBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<MedicalVisitFilterBar> createState() => _MedicalVisitFilterBarState();
}

class _MedicalVisitFilterBarState extends State<MedicalVisitFilterBar> {
  DateTime? _fromDate;
  DateTime? _toDate;

  void _pickDate({required bool isFrom}) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime.now(),
      currentTime:
          isFrom ? (_fromDate ?? DateTime.now()) : (_toDate ?? DateTime.now()),
      locale: LocaleType.vi,
      onConfirm: (date) {
        setState(() {
          if (isFrom) {
            _fromDate = date;
          } else {
            _toDate = date;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fromText = _fromDate != null
        ? DateFormat('dd-MM-yyyy').format(_fromDate!)
        : 'Từ ngày';
    final toText = _toDate != null
        ? DateFormat('dd-MM-yyyy').format(_toDate!)
        : 'Đến ngày';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'DANH SÁCH CÁC ĐỢT ĐIỀU TRỊ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickDate(isFrom: true),
                  child: _DateBox(text: fromText),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => _pickDate(isFrom: false),
                  child: _DateBox(text: toText),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 45,
                width: 45,
                child: ElevatedButton(
                  onPressed: () => widget.onSearch(_fromDate, _toDate),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Icon(Icons.search, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final String text;

  const _DateBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.calendar_today, size: 18),
        ],
      ),
    );
  }
}

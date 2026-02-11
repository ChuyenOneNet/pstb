import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';

class PatientCodeSearchSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isBusy;
  final VoidCallback onSearch;
  final VoidCallback? onClear;

  const PatientCodeSearchSection({
    Key? key,
    required this.controller,
    required this.isBusy,
    required this.onSearch,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nhập mã bệnh nhân',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mã bệnh nhân',
                    hintText: 'Ví dụ: 25055656',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    filled: true,
                    fillColor: const Color(0xFFF7F8FC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Flexible(
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isBusy ? null : onSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: isBusy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Tra cứu',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

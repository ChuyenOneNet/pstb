/// perform_medicine_orders_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../widget/medicine_order_item.dart';
import 'medicine_order_store.dart';

class PerformMedicineOrdersPage extends StatefulWidget {
  final String patientCode;
  final String patientInfo;
  final String executionDate;

  const PerformMedicineOrdersPage({
    required this.patientCode,
    required this.patientInfo,
    required this.executionDate,
  });

  @override
  State<PerformMedicineOrdersPage> createState() =>
      _PerformMedicineOrdersPageState();
}

class _PerformMedicineOrdersPageState extends State<PerformMedicineOrdersPage>
    with TickerProviderStateMixin {
  late final MedicineOrderStore store;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    store = MedicineOrderStore();
    store.fetchOrders();
  }

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    await store.submitOrders();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: store,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => Modular.to.pop(),
              child: Icon(Icons.arrow_back_ios, color: Colors.white)),
          title: const Text(
            'THỰC HIỆN THUỐC',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                '${widget.patientCode} | ${widget.patientInfo}',
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text('NGÀY THỰC HIỆN THUỐC : ${widget.executionDate}'),
              const SizedBox(height: 12),
              Observer(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: store.isAllSelected,
                          onChanged: (_) => store.toggleAll(),
                        ),
                        InkWell(
                          onTap: () => store.toggleAll(),
                          child: const Text('Tất cả'),
                        ),
                      ],
                    ),
                    const Text(
                      'SL',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Observer(
                  builder: (_) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: ListView.separated(
                      key: ValueKey(store.orders.length),
                      itemCount: store.orders.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) => MedicineOrderItem(
                        order: store.orders[index],
                        onChanged: () => store.toggleItem(index),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.sub_yellow),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Quay lại',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      onPressed: _isLoading ? null : _handleSubmit,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text(
                              'Tiếp tục',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.orange),
                  //     onPressed: () async {
                  //       final selected = store.selectedOrders;
                  //       print('Đã chọn ${selected.length} y lệnh.');
                  //       await store.submitOrders();
                  //     },
                  //     child: const Text('Tiếp tục'),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

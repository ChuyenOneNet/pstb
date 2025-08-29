import 'package:flutter/material.dart';

import '../../../models/perform_medicine/medicine_order.dart';

class MedicineOrderItem extends StatelessWidget {
  final MedicineOrder order;
  final VoidCallback onChanged;

  const MedicineOrderItem({
    required this.order,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final color = order.available < order.total ? Colors.red : Colors.black;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: order.isSelected,
          onChanged: (_) => onChanged(),
        ),
        Expanded(
          child:
              InkWell(onTap: () => onChanged(), child: Text(order.orderText)),
        ),
        const SizedBox(width: 8),
        Text('${order.available} | ${order.total}',
            style: TextStyle(color: color)),
      ],
    );
  }
}

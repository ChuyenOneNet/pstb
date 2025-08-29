import 'package:flutter/material.dart';
import 'package:pstb/app/models/category_disease_model.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/styles.dart';

class ItemCategoryWidget extends StatelessWidget {
  const ItemCategoryWidget({
    Key? key,
    required this.categoryDiseaseModel,
  }) : super(key: key);

  final CategoryDiseaseModel categoryDiseaseModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              categoryDiseaseModel.image ?? '',
              fit: BoxFit.fill,
              errorBuilder: (_, __, ___) {
                return const SizedBox.shrink();
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Text(
                categoryDiseaseModel.name ?? '',
                style: Styles.content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

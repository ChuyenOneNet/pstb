import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/community/group_diseases_page/category_diseases_store.dart';
import 'package:pstb/app/modules/community/question_page/widgets/gradient_button_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

import 'widgets/item_category_widget.dart';

class CategoryDiseasesPage extends StatefulWidget {
  const CategoryDiseasesPage({Key? key}) : super(key: key);

  @override
  State<CategoryDiseasesPage> createState() => _CategoryDiseasesPageState();
}

class _CategoryDiseasesPageState
    extends ModularState<CategoryDiseasesPage, CategoryDiseasesStore> {
  @override
  void initState() {
    controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context).group_diseases,
      ),
      body: Column(
        children: [
          Observer(builder: (context) {
            return Expanded(
              flex: 8,
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12),
                itemBuilder: (_, index) {
                  final categoryDiseaseModel = controller.category[index];
                  return InkWell(
                    onTap: () async {
                      await controller.pushDetailAnswer(categoryDiseaseModel);
                      Modular.to.pushNamed(AppRoutes.detailAnswer);
                    },
                    child: ItemCategoryWidget(
                        categoryDiseaseModel: categoryDiseaseModel),
                  );
                },
                itemCount: controller.category.length,
              ),
            );
          }),
          // Expanded(
          //   child: Row(
          //     children: [
          //       const Spacer(),
          //       Expanded(
          //         flex: 3,
          //         child: GradientButtonWidget(
          //           radius: 8,
          //           titleButton: l10n(context).set_up_question_free,
          //           onTap: () {
          //             Modular.to.pushNamed(AppRoutes.setUpQuestion);
          //           },
          //         ),
          //       ),
          //       const Spacer(),
          //     ],
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Modular.to.pushNamed(AppRoutes.setUpQuestion);
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}

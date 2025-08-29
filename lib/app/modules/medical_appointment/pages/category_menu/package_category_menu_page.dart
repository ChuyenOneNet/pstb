import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/category_model.dart';
import 'package:pstb/app/modules/medical_appointment/medical_appointment_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';

class CategoryMenuItemViewModel {
  int categoryGroupId;
  String name;
  String image;

  CategoryMenuItemViewModel(this.categoryGroupId, this.name, this.image);
}

class PackageCategoryMenuPage extends StatefulWidget {
  const PackageCategoryMenuPage({Key? key}) : super(key: key);

  @override
  State<PackageCategoryMenuPage> createState() =>
      _PackageCategoryMenuPageState();
}

class _PackageCategoryMenuPageState extends State<PackageCategoryMenuPage> {
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();

  final List<CategoryMenuItemViewModel> _items = <CategoryMenuItemViewModel>[
    CategoryMenuItemViewModel(PackageCategoryGroup.TAM_SOAT_UNG_THU, '',
        'assets/images/category_tam_soat_ung_thu.png'),
    CategoryMenuItemViewModel(PackageCategoryGroup.KHAM_SUC_KHOE, '',
        'assets/images/category_tong_quat_dinh_ky.png'),
    CategoryMenuItemViewModel(-1, '', 'assets/images/category_tre_em.png'),
    CategoryMenuItemViewModel(
        -1, '', 'assets/images/category_kham_tai_benh_vien_khac.png'),
    CategoryMenuItemViewModel(
        PackageCategoryGroup.TU_VAN, '', 'assets/images/category_tu_van.png'),
    CategoryMenuItemViewModel(PackageCategoryGroup.RANG_HAM_MAT, '',
        'assets/images/category_rang_ham_mat.png'),
    CategoryMenuItemViewModel(-1, '', 'assets/images/category_vacxin.png'),
    CategoryMenuItemViewModel(PackageCategoryGroup.KHAM_COVID, '',
        'assets/images/category_covid.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context)!.package_group_page_title!,
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(_items.length, (index) {
          var item = _items[index];
          return GestureDetector(
            onTap: () {
              if (item.categoryGroupId > 0) {
                _medicalAppointmentStore
                    .setCategoryGroupId(item.categoryGroupId.toString());
                if (item.categoryGroupId == PackageCategoryGroup.KHAM_COVID) {
                  Modular.to
                      .pushNamed(AppRoutes.medicalAppointmentCovidDeclaration);
                } else {
                  Modular.to.pushNamed(AppRoutes.medicalPackagePage,
                      arguments: false);
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(item.image,
                  height: heightConvert(context, 210),
                  width: widthConvert(context, 160),
                  fit: BoxFit.fill),
            ),
          );
        }),
      ),
    );
  }
}

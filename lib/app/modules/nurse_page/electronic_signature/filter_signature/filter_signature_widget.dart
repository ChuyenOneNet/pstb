import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/widgets/document_type_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'widgets/date_filter_widget.dart';
import 'widgets/department_filter_widget.dart';
import 'widgets/patient_filter_widget.dart';
import 'widgets/roles_signature_widget.dart';
import 'widgets/search_roles_signature_widget.dart';
import 'widgets/status_signature_widget.dart';

class FilterSignatureWidget extends StatefulWidget {
  const FilterSignatureWidget({Key? key}) : super(key: key);

  @override
  State<FilterSignatureWidget> createState() => _FilterSignatureWidgetState();
}

class _FilterSignatureWidgetState extends State<FilterSignatureWidget> {
  final _filterStore = Modular.get<FilterSignatureStore>();
  late final TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3 * 2,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchRoleSignatureWidget(
            fieldController: searchController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RolesSignatureWidget(),
          ),
          const DocumentTypeWidget(),
          DateFilterWidget(),
          PatientFilterWidget(),
          const DepartmentFilterWidget(),
          StatusSignatureWidget(),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: 'Thiết lập lại',
                  onPressed: () {
                    Modular.get<FilterSignatureStore>().clearStateFilter();
                    searchController.clear();
                  },
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                  child: AppButton(
                primaryColor: AppColors.success,
                title: 'Áp dụng',
                onPressed: () async {
                  if (_filterStore.roleCode == null) {
                    Fluttertoast.showToast(
                        msg: 'Hãy chọn vai trò ký',
                        backgroundColor: AppColors.error500);
                    return;
                  }
                  if (_filterStore.resultError.isNotEmpty) {
                    Fluttertoast.showToast(msg: _filterStore.resultError);
                    return;
                  }
                  EasyLoading.show();
                  await _filterStore.onConfirmFilter();
                  EasyLoading.dismiss();
                  Modular.to.pop(context);
                },
              ))
            ],
          )
        ],
      ),
    );
  }
}

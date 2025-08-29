import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';

class SearchRoleSignatureWidget extends StatelessWidget {
  SearchRoleSignatureWidget({Key? key, this.fieldController}) : super(key: key);
  final _filterStore = Modular.get<FilterSignatureStore>();
  final TextEditingController? fieldController;
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: fieldController,
      onChanged: (value) {
        _filterStore.onChangedValueSearch(value: value);
      },
      placeholder: 'Tìm kiếm tên tài liệu',
    );
  }
}

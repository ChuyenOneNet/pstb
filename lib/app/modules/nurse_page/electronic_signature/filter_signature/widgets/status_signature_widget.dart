import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/utils/main.dart';

class StatusSignatureWidget extends StatelessWidget {
  StatusSignatureWidget({
    Key? key,
  }) : super(key: key);
  final _filterSignatureStore = Modular.get<FilterSignatureStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: AppColors.lightSilver, borderRadius: BorderRadius.circular(8)),
      child: Observer(
        builder: (context) {
          return DropdownButton<int>(
            onChanged: (value) {
              _filterSignatureStore.onChangeSigningStatus(
                  signingStatusSelected: value);
            },
            hint: Text(
              'Trạng thái',
              style: Styles.content,
            ),
            value: _filterSignatureStore.idSigningStatus,
            items: List.generate(
                Constants.listStatusSignature.length,
                (index) => DropdownMenuItem(
                      value: index,
                      child: Text(Constants.listStatusSignature[index]),
                    )),
            underline: const SizedBox(),
            isExpanded: true,
          );
        }
      ),
    );
  }
}

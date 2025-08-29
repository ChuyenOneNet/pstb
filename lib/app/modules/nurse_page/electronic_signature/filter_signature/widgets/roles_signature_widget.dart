import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/nurse_page/electronic_signature/filter_signature/filter_signature_store.dart';
import 'package:pstb/utils/main.dart';

class RolesSignatureWidget extends StatelessWidget {
  RolesSignatureWidget({
    Key? key,
  }) : super(key: key);
  final _filterSignature = Modular.get<FilterSignatureStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: AppColors.lightSilver, borderRadius: BorderRadius.circular(8)),
      child: Observer(builder: (context) {
        return DropdownButton<String>(
          hint: Text(
            'Vai trò ký',
            style: Styles.subtitleSmallest,
          ),
          value: _filterSignature.roleCode,
          items: List.generate(
            _filterSignature.signers.length,
            (index) {
              final signerRole = _filterSignature.signers[index];
              return DropdownMenuItem(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Text(signerRole.name ?? '')),
                value: signerRole.code,
              );
            },
          ),
          onChanged: (value) {
            _filterSignature.onChangeRollSigner(value);
          },
          underline: const SizedBox(),
          isExpanded: true,
        );
      }),
    );
  }
}

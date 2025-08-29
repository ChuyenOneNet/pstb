import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/app_store.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';
import '../../../../utils/routes.dart';
import '../../../../utils/styles.dart';
import '../../../models/medical_unit/hospital_unit_model.dart';
import '../../../user_app_store.dart';
import '../selection_hospital_store.dart';

class AutocompleteBasicHospital extends StatelessWidget {
  final SelectionHospitalStore selectionHospitalStore =
      Modular.get<SelectionHospitalStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final AppStore appStore = Modular.get<AppStore>();

  AutocompleteBasicHospital({Key? key}) : super(key: key);

  static String _displayStringForOption(HospitalModel hospital) =>
      hospital.name ?? '';

  @override
  Widget build(BuildContext context) {
    return Autocomplete<HospitalModel>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<HospitalModel>.empty();
        }
        return selectionHospitalStore.listHospital
            .where((HospitalModel option) {
          return option.name!
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: CupertinoSearchTextField(
            autofocus: true,
            placeholder: 'Tìm kiếm cơ sở y tế',
            placeholderStyle:
                Styles.titleItem.copyWith(color: AppColors.lightSilver),
            controller: textEditingController,
            focusNode: focusNode,
            style: Styles.titleItem,
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) => Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0.0)),
        ),
        child: Container(
          color: AppColors.background,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            shrinkWrap: false,
            itemBuilder: (BuildContext context, int index) {
              final HospitalModel option = options.elementAt(index);
              return InkWell(
                onTap: () => onSelected(option),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        // borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          height: 40,
                          width: 40,
                          imageUrl: option.image ?? '',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Image.asset(ImageEnum.hospitalDefault),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                child: Text(
                              '${option.name}',
                              style: Styles.content,
                            )),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${option.address}',
                              style: Styles.content,
                            )
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        size: 28,
                        color: AppColors.lightSilver,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onSelected: (HospitalModel selection) {
        var nameHospital = _displayStringForOption(selection);
        for (var element in selectionHospitalStore.listHospital) {
          if (nameHospital == element.name) {
            Modular.to.pushNamed(AppRoutes.detailHospitalPage, arguments: {
              "hospitalModel": selection,
            });
            _userAppStore.hospital = selection;
            return;
          }
        }
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/images.dart';
import '../../../../../../utils/routes.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../user_app_store.dart';
import '../../../medical_appointment_store.dart';
import '../../select_doctor/models/doctor_model.dart';
import '../../select_doctor/select_doctor_store.dart';

class AutocompleteBasicDoctor extends StatelessWidget {
  final SelectDoctorStore _selectDoctorStore = Modular.get<SelectDoctorStore>();
  final MedicalAppointmentStore _medicalAppointmentStore =
      Modular.get<MedicalAppointmentStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();

  AutocompleteBasicDoctor({
    Key? key,
  }) : super(key: key);

  static String _displayStringForOption(DoctorPagingItem doctor) =>
      doctor.name ?? '';

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Autocomplete<DoctorPagingItem>(
        displayStringForOption: _displayStringForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<DoctorPagingItem>.empty();
          }
          return _selectDoctorStore.listDoctor
              .where((DoctorPagingItem option) {
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
              placeholder: 'Tìm kiếm bác sĩ',
              placeholderStyle:
                  Styles.heading4.copyWith(color: AppColors.lightSilver),
              controller: textEditingController,
              focusNode: focusNode,
              style: Styles.heading4.copyWith(color: AppColors.black),
            ),
          );
        },
        optionsViewBuilder: (context, onSelected, options) =>
            Material(
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(0.0)),
          ),
          child: Container(
            color: AppColors.background,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: options.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, int index) {
                final DoctorPagingItem option = options.elementAt(index);
                return InkWell(
                  onTap: () => onSelected(option),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            height: 40,
                            width: 40,
                            imageUrl: option.image ?? '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Image.asset(ImageEnum.avatarDefault),
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
                                    style: Styles.subtitleSmallest.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  )),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${option.position}',
                                style: Styles.subtitleSmallest,
                              )
                            ],
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right,size: 28, color: AppColors.lightSilver,),
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
        onSelected: (DoctorPagingItem selection) {
          var nameDoctor = _displayStringForOption(selection);
          for (var element in _selectDoctorStore.listDoctor) {
            if (nameDoctor == element.name) {
              _medicalAppointmentStore.chooseDoctor(element);
              _userAppStore.doctor = element;
              _selectDoctorStore.idDoctor = element.id!;
              _selectDoctorStore.navigateTo(
                  AppRoutes.doctorInfo, _selectDoctorStore.idDoctor);
              return;
            }
          }
        },
      );
    });
  }
}

import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/detail_therapy_store.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:mobx/mobx.dart';

part 'create_care_store.g.dart';

class CreateCareStore = _CreateCareStoreBase with _$CreateCareStore;

abstract class _CreateCareStoreBase with Store {
  final _helper = Modular.get<ApiBaseHelper>();
  final patientId = Modular.get<DetailTherapyStore>().id;
  final codeNurse = Modular.get<NurseSearchingStore>().codeNurse;
  String breathing = "";
  String temperature = "";
  String pulse = "";
  String max = "";
  String min = "";
  String attentionInformation = "";
  String progression = "";

  Future<void> setNursingWithPatient() async {
    EasyLoading.show();
    final data = jsonEncode(NurseModel(
            breathing: int.parse(breathing),
            temperature: double.parse(temperature),
            pulse: int.parse(pulse),
            bloodPressure: '$max/$min',
            attentionInformation: attentionInformation,
            progression: progression,
            staffCode: codeNurse,
            patientCode: patientId,
            time: TimeUtil.format(DateTime.now(), TimeUtil.DDMMYYYYHHMM))
        .toJson());
    try {
      await _helper.post(ApiUrl.staffCare, data);
      Fluttertoast.showToast(msg: "Cập nhật thành công");
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
    }
  }
}

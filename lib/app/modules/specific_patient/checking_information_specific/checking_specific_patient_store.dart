import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/indication_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:mobx/mobx.dart';

import '../../../models/department_model.dart';
import '../../../models/patient_model.dart';

part 'checking_specific_patient_store.g.dart';

class CheckingSpecificPatientStore = CheckingSpecificPatientStoreBase
    with _$CheckingSpecificPatientStore;

abstract class CheckingSpecificPatientStoreBase with Store {
  final _request = Modular.get<ApiBaseHelper>();
  @observable
  List<IndicationModel>? listRegistration;
  String? errorMessage;

  @action
  Future<void> initState() async {
    try {
      // final data = await _request.get(ApiUrl.indicationRegistration);
      // listRegistration =
      //     List.of((data as List).map((e) => IndicationModel.fromJson(e)));
      // if (listRegistration == null) {
      //   listRegistration = [];
      // } else {
      //   listRegistration = listRegistration!.reversed.toList();
      // }
      listRegistration = [
        IndicationModel(
          id: "1",
          departmentModel: DepartmentModel(
            id: "d1",
            code: "K01",
            name: "Khoa Khám bệnh tổng quát",
          ),
          patientQrModel: PatientQrModel(
            id: "p1",
            code: "BN001",
            name: "Nguyễn Văn A",
            age: "30",
            qrCode: "QR001",
          ),
        ),
        IndicationModel(
          id: "2",
          departmentModel: DepartmentModel(
            id: "d2",
            code: "K02",
            name: "Khoa Nội tổng hợp",
          ),
          patientQrModel: PatientQrModel(
            id: "p2",
            code: "BN002",
            name: "Trần Thị B",
            age: "45",
            qrCode: "QR002",
          ),
        ),
        IndicationModel(
          id: "3",
          departmentModel: DepartmentModel(
            id: "d3",
            code: "K03",
            name: "Khoa Nhi",
          ),
          patientQrModel: PatientQrModel(
            id: "p3",
            code: "BN003",
            name: "Lê Văn C",
            age: "10",
            qrCode: "QR003",
          ),
        ),
      ];
    } on AppException catch (e) {
      errorMessage = e.toString();
    }
  }
}

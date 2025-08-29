import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/models/patient_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/services/api_exception.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/time_util.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'nurse_searching_store.g.dart';

class NurseSearchingStore = _NurseSearchingStoreBase with _$NurseSearchingStore;

abstract class _NurseSearchingStoreBase with Store {
  final ApiBaseHelper _helper = Modular.get<ApiBaseHelper>();
  @observable
  NurseModel nurseModel = NurseModel();
  @observable
  PatientModel patientModel = PatientModel();
  @observable
  String nameFile = '';
  @observable
  String codeNurse = '';
  @observable
  String nameNurse = '';
  @observable
  String codeDepartment = '';
  @observable
  String codePatient = '';
  @observable
  String breathing = '';
  @observable
  String temperature = '';
  @observable
  String pulse = '';
  @observable
  String bloodPressure = '';
  @observable
  String progression = '';
  @observable
  String attentionInformation = '';
  @observable
  bool isActiveSearchLocation = false;
  @observable
  bool isActivePatient = false;
  @observable
  bool isLoading = false;
  @observable
  bool isDone = false;
  @observable
  String dateTime = TimeUtil.format(DateTime.now(), TimeUtil.HHMMDDMMYYYY);
  @observable
  bool isActiveInputHealthCare = false;
  @observable
  bool isActivePaper = false;
  @observable
  bool isHiddenButton = true;
  @observable
  bool isActiveButton = true;
  @observable
  bool isProgression = true;
  @observable
  String descriptionPaper = '';
  @observable
  String? pickImage;
  @observable
  String? displayImage;
  @observable
  String? documentPath;
  @observable
  String max = '';
  @observable
  String min = '';
  XFile? fileImg;
  XFile? displayFileImg;
  PlatformFile? fileDocument;
  String? errorMessage;

  @action
  Future<void> initState() async {
    final pref = await Modular.getAsync<SharedPreferences>();
    codeNurse = pref.getString(Constants.codeNursing) ?? '';
    nameNurse = pref.getString(Constants.nameNursing) ?? '';
    print(nameNurse);
    await pressActiveLocation();
  }

  @action
  void setCodeNurse(String value) {
    codeNurse = value;
  }

  @action
  void setNameFile(String value) {
    nameFile = value;
  }

  @action
  void setNameRoom(String value) {
    codeDepartment = value;
  }

  @action
  void setCodePatient(String value) {
    codePatient = value;
  }

  @action
  void setActionButton(int index) {
    isHiddenButton = false;
    isActivePatient = false;
    isActiveButton = false;
    switch (index) {
      case 0:
        isActiveInputHealthCare = true;
        return;
      case 1:
        isActivePaper = true;
        return;
      default:
        isActiveButton = true;
        isHiddenButton = true;
        return;
    }
  }

  @action
  void onActionSelectedPopup(Object? value) {
    switch (value) {
      case 0:
        isActiveInputHealthCare = true;
        isActivePaper = false;
        return;
      case 1:
        isActivePaper = true;
        isActiveInputHealthCare = false;
        return;
      default:
        return;
    }
  }

  @action
  Future<void> pressActiveLocation() async {
    EasyLoading.show();
    try {
      final shared = await SharedPreferences.getInstance();
      final response = await _helper.get(
        ApiUrl.getStaffInfo,
        // {
        //   'code': codeNurse,
        //   'password': password,
        // },
      );
      if (response != null) {
        isActiveSearchLocation = true;
        nurseModel = NurseModel.fromJson(response);
        nameNurse = nurseModel.name!;
        codeNurse = nurseModel.code!;
        final pref = await Modular.getAsync<SharedPreferences>();
        pref.setString(Constants.codeNursing, nurseModel.code!);
        pref.setString(Constants.nameNursing, nurseModel.name!);
      }
    } on AppException catch (e) {
      EasyLoading.dismiss();
      isHiddenButton = true;
      errorMessage = e.toString();
    }
    EasyLoading.dismiss();
  }

  @action
  Future<void> pressActivePatient() async {
    EasyLoading.show();
    try {
      final response = await _helper.get(ApiUrl.staffPatient, {
        'patientCode': codePatient,
      });
      if (response != null) {
        isActivePatient = true;
        final nurse = NurseModel.fromJson(response);
        patientModel = PatientModel.fromJson(response);
        nurseModel.departmentName = nurse.departmentName;
        EasyLoading.dismiss();
      }
    } catch (e) {
      isActivePatient = false;
    }
    EasyLoading.dismiss();
  }

  @action
  Future<void> uploadDocumentImage(String patientCode, String staffCode) async {
    if (fileImg == null || pickImage == null || pickImage!.isEmpty) {
      Fluttertoast.showToast(msg: 'Chưa có tài liệu');
    } else {
      try {
        EasyLoading.show();
        isDone = false;
        var response = await _helper.uploadDocumentImage(
          nameFile,
          ApiUrl.staffUploadDocument,
          fileImg!,
          (_, __) => {},
          ((error) {
            errorMessage = error;
          }),
          {
            'patientCode': patientCode,
            'staffCode': staffCode,
          },
        );
        if (response == null || response == false) {
          EasyLoading.dismiss();
          isDone = false;
        } else {
          EasyLoading.dismiss();
          isDone = true;
        }
        isHiddenButton = false;
        isActivePatient = false;
        isActiveButton = false;
      } catch (e) {
        isDone = false;
        EasyLoading.dismiss();
        return;
      }
    }
  }

  @action
  Future<void> uploadDocument(String patientCode, String staffCode) async {
    if (fileDocument == null) {
      Fluttertoast.showToast(msg: 'Chưa có tài liệu');
    } else {
      try {
        isDone = false;
        EasyLoading.show();
        await _helper.uploadDocument(
          nameFile,
          ApiUrl.staffUploadDocument,
          fileDocument!,
          (_, __) => {},
          ((error) {
            errorMessage = error;
          }),
          {
            'patientCode': patientCode,
            'staffCode': staffCode,
          },
        );
        EasyLoading.dismiss();
        isDone = true;
      } catch (e) {
        EasyLoading.dismiss();
        return;
      }
    }
  }

  @action
  void backInitStateNursingPage() {
    isHiddenButton = false;
    isActivePatient = false;
    isActiveButton = false;
  }

  @action
  Future<void> setNursingWithPatient() async {
    dateTime = TimeUtil.format(DateTime.now(), TimeUtil.DDMMYYYYHHMM);
    EasyLoading.show();
    final data = jsonEncode(NurseModel(
            breathing: int.parse(breathing),
            temperature: double.parse(temperature),
            pulse: int.parse(pulse),
            bloodPressure: '$max/$min',
            attentionInformation: attentionInformation,
            progression: progression,
            staffCode: codeNurse,
            patientCode: codePatient,
            time: dateTime)
        .toJson());
    try {
      isDone = false;
      await _helper.post(ApiUrl.staffCare, data);
      isDone = true;
      isHiddenButton = false;
      isActivePatient = false;
      isActiveButton = false;
      EasyLoading.dismiss();
    } catch (e) {
      isDone = false;
      EasyLoading.dismiss();
    }
  }

  @action
  void setBreathing(String value) {
    breathing = value;
  }

  @action
  void setTemperature(String value) {
    temperature = value;
  }

  @action
  void setCircuit(String value) {
    pulse = value;
  }

  @action
  void setBloorPressureMax(String value) {
    max = value;
  }

  @action
  void setBloorPressureMin(String value) {
    min = value;
  }

  @action
  void setDevelopments(String value) {
    progression = value;
  }

  @action
  void setHealthCare(String value) {
    attentionInformation = value;
  }

  @action
  void setDescriptionPaper(String value) {
    descriptionPaper = value;
  }

  @action
  void onChangeImage(XFile file) {
    pickImage = file.path.trim();
    displayImage = file.path.trim();
    fileImg = file;
    displayFileImg = file;
  }

  @action
  void onChangeFile(PlatformFile file) {
    documentPath = file.path;
    fileDocument = file;
  }
}

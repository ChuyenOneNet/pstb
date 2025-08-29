import 'package:mobx/mobx.dart';

part 'specific_patient_store.g.dart';

class SpecificPatientStore = SpecificPatientStoreBase
    with _$SpecificPatientStore;

abstract class SpecificPatientStoreBase with Store {
  @observable
  bool isSuccessPatient = false;
  void initState() {

  }

  @action
  void searchingPatient() {
  }

  @action
  void onSubmitPatient() {
    isSuccessPatient = true;
  }
}

import 'package:mobx/mobx.dart';
import '../../../models/perform_medicine/medicine_usage_model.dart';

part 'medicine_usage_store.g.dart';

class MedicineUsageStore = _MedicineUsageStore with _$MedicineUsageStore;

abstract class _MedicineUsageStore with Store {
  @observable
  ObservableList<MedicineUsageModel> usages = ObservableList.of([]);

  @action
  void setUsages(List<MedicineUsageModel> data) {
    usages = ObservableList.of(data);
  }

  @action
  void updateWholeAmount(int index, double value) {
    usages[index].wholeAmount = value;
  }

  @action
  void updatePartialAmount(int index, double value) {
    usages[index].partialAmount = value;
  }

  @action
  void toggleBeforeMeal(int index, bool value) {
    usages[index].beforeMeal = value;
  }

  @action
  void toggleAfterMeal(int index, bool value) {
    usages[index].afterMeal = value;
  }

  @action
  void toggleHasProgress(int index, bool value) {
    usages[index].hasProgress = value;
  }

  @action
  void toggleIsOther(int index, bool value) {
    usages[index].isOther = value;
  }
}

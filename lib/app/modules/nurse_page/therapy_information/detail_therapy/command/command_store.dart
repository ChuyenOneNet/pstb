import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/command_model.dart';
import 'package:pstb/services/api_base_helper.dart';
import 'package:pstb/utils/api_url.dart';
import 'package:mobx/mobx.dart';

part 'command_store.g.dart';

class CommandStore = _CommandStoreBase with _$CommandStore;

abstract class _CommandStoreBase with Store {
  @observable
  CommandModel? commandData;
  final _callApi = Modular.get<ApiBaseHelper>();
  String? id;

  @observable
  bool isLoading = true;
  Future<void> getDetailTreatmentCommand() async {
    isLoading = true;
    final response = await _callApi.get(ApiUrl.getCommand, {
      "id": id,
    });
    if (response != null) {
      commandData = CommandModel.fromJson(response);
    }
    isLoading = false;
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repositories/request_repository.dart';
import '../../../../di/locator.dart';
import '../model/create_request_model.dart';

part 'create_request_state.dart';

class CreateRequestCubit extends Cubit<CreateRequestState> {
  final repository = serviceLocator<RequestRepository>();

  CreateRequestCubit() : super(CreateRequestInitial());

  Future<void> submitRequest(CreateRequestModel model, String userPhone) async {
    emit(CreateRequestLoading());
    try {
      await repository.createRequest(model, userPhone);
      print("ok1");
      print(model.toJson());
      print(userPhone);
      emit(CreateRequestSuccess());
    } catch (e) {
      emit(CreateRequestFailure(e.toString()));
    }
  }
}

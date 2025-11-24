import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../data/repositories/signature_repository.dart';
import 'sign_action_state.dart';

final _sl = GetIt.instance;

class SignActionCubit extends Cubit<SignActionState> {
  SignActionCubit() : super(const SignActionState());

  SignatureRepository get _repo => _sl<SignatureRepository>();

  Future<void> sign({
    required String userName,
    required String roleCode,
    required List<String> ids,
  }) async {
    emit(state.copyWith(status: SignActionStatus.signing));
    try {
      await _repo.signV1(userName: userName, roleCode: roleCode, ids: ids);
      emit(state.copyWith(
          status: SignActionStatus.success, message: 'Ký thành công'));
    } catch (e) {
      emit(state.copyWith(
          status: SignActionStatus.failure, message: e.toString()));
    }
  }

  Future<void> revoke({
    required String userName,
    required List<String> ids,
  }) async {
    emit(state.copyWith(status: SignActionStatus.revoking));
    try {
      await _repo.revokeV1(userName: userName, ids: ids);
      emit(state.copyWith(
          status: SignActionStatus.success, message: 'Thu hồi thành công'));
    } catch (e) {
      emit(state.copyWith(
          status: SignActionStatus.failure, message: e.toString()));
    }
  }
}

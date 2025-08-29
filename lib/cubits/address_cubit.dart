import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pstb/core/repositories/dropdown_repository.dart';

import '../di/locator.dart';
import '../models/address_model.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Address> list;

  AddressLoaded(this.list);
}

class AddressError extends AddressState {
  final String message;

  AddressError(this.message);
}

class AddressCubit extends Cubit<AddressState> {
  final repo = serviceLocator<DropdownRepository>();

  AddressCubit() : super(AddressInitial());

  Future<void> fetchAddresses(String filter, int type) async {
    emit(AddressLoading());
    try {
      final list = await repo.getAddresses(filter, type);
      print(list);
      // final allAddresses = [
      //   Address(id: '1', name: 'Quận Ba Đình, Hà Nội'),
      //   Address(id: '2', name: 'Quận Hoàn Kiếm, Hà Nội'),
      //   Address(id: '3', name: 'Quận 1, TP Hồ Chí Minh'),
      //   Address(id: '4', name: 'Quận 3, TP Hồ Chí Minh'),
      // ];
      emit(AddressLoaded(list));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}

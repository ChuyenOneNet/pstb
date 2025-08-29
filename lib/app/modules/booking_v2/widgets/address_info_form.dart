import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/address_cubit.dart';
import '../../../../cubits/ethnic_cubit.dart';
import '../../../../cubits/nationality_cubit.dart';
import '../../../../models/address_model.dart';
import '../../../../models/ethnic_model.dart';
import '../../../../models/nationality_model.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/dropdown/api_dropdown.dart';
import '../../../../widgets/text_field/input_text_field.dart';

class AddressInfoForm extends StatelessWidget {
  final TextEditingController addressDetailController;
  final Address? selectedAddress;
  final Function(Address?) onAddressChanged;
  final Nationality selectedNationality;
  final Function(Nationality?) onNationalityChanged;
  final Ethnic selectedEthnic;
  final Function(Ethnic?) onEthnicChanged;

  const AddressInfoForm({
    Key? key,
    required this.addressDetailController,
    required this.selectedAddress,
    required this.onAddressChanged,
    required this.selectedNationality,
    required this.onNationalityChanged,
    required this.selectedEthnic,
    required this.onEthnicChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Address Dropdown
        BlocProvider<AddressCubit>(
          create: (context) => AddressCubit()..fetchAddresses('', 0),
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              return ApiDropdown<Address, AddressCubit, AddressState>(
                selected: selectedAddress,
                onChanged: onAddressChanged,
                itemAsString: (item) => item.name,
                isLoading: (state) => state is AddressLoading,
                isError: (state) => state is AddressError,
                getErrorMessage: (state) =>
                    state is AddressError ? state.message : '',
                getItems: (state) => state is AddressLoaded ? state.list : [],
                hintText: "Chọn quận/huyện/thành phố *",
                onSearch: (filter) async {
                  await context.read<AddressCubit>().fetchAddresses(filter, 0);
                  final st = context.read<AddressCubit>().state;
                  if (st is AddressLoaded) return st.list;
                  return [];
                },
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        InputTextField(
          textController: addressDetailController,
          label: 'Địa chỉ chi tiết (thôn/ngõ/ngách/số nhà)',
          prefixIcon:
              Icon(Icons.home_filled, size: 20, color: AppColors.primary),
          validator: (_) => null,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 14),

        // Nationality Dropdown
        BlocProvider<NationalityCubit>(
          create: (_) => NationalityCubit()..fetchNationalities('Việt Nam'),
          child: BlocBuilder<NationalityCubit, NationalityState>(
            builder: (context, state) {
              return ApiDropdown<Nationality, NationalityCubit,
                  NationalityState>(
                selected: selectedNationality,
                onChanged: onNationalityChanged,
                itemAsString: (item) => item.name,
                isLoading: (state) => state is NationalityLoading,
                isError: (state) => state is NationalityError,
                getErrorMessage: (state) =>
                    state is NationalityError ? state.message : '',
                getItems: (state) =>
                    state is NationalityLoaded ? state.list : [],
                hintText: "Chọn quốc tịch *",
                onSearch: (filter) async {
                  await context
                      .read<NationalityCubit>()
                      .fetchNationalities(filter);
                  final st = context.read<NationalityCubit>().state;
                  if (st is NationalityLoaded) return st.list;
                  return [];
                },
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // Ethnic Dropdown
        BlocProvider<EthnicCubit>(
          create: (_) => EthnicCubit()..fetchEthnics('Kinh'),
          child: BlocBuilder<EthnicCubit, EthnicState>(
            builder: (context, state) {
              return ApiDropdown<Ethnic, EthnicCubit, EthnicState>(
                selected: selectedEthnic,
                onChanged: onEthnicChanged,
                itemAsString: (item) => item.name,
                isLoading: (state) => state is EthnicLoading,
                isError: (state) => state is EthnicError,
                getErrorMessage: (state) =>
                    state is EthnicError ? state.message : '',
                getItems: (state) => state is EthnicLoaded ? state.list : [],
                hintText: "Chọn dân tộc *",
                onSearch: (filter) async {
                  await context.read<EthnicCubit>().fetchEthnics(filter);
                  final st = context.read<EthnicCubit>().state;
                  if (st is EthnicLoaded) return st.list;
                  return [];
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

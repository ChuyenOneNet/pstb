import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pstb/cubits/nationality_cubit.dart';
import '../../../../cubits/address_cubit.dart';
import '../../../../cubits/ethnic_cubit.dart';
import '../../../../cubits/city_cubit.dart';
import '../../../../models/address_model.dart';
import '../../../../models/ethnic_model.dart';
import '../../../../models/nationality_model.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/dropdown/api_dropdown.dart';
import '../../../../widgets/text_field/input_text_field.dart';

class AddressInfoForm extends StatefulWidget {
  final TextEditingController addressDetailController;
  final Address? selectedAddress;
  final Function(Address?) onAddressChanged;
  final Nationality selectedNationality;
  final Function(Nationality?) onNationalityChanged;
  final Ethnic selectedEthnic;
  final Function(Ethnic?) onEthnicChanged;
  final Address? selectedCity;
  final Function(Address?) onCityChanged;

  const AddressInfoForm({
    Key? key,
    required this.addressDetailController,
    required this.selectedAddress,
    required this.onAddressChanged,
    required this.selectedNationality,
    required this.onNationalityChanged,
    required this.selectedEthnic,
    required this.onEthnicChanged,
    required this.selectedCity,
    required this.onCityChanged,
  }) : super(key: key);

  @override
  State<AddressInfoForm> createState() => _AddressInfoFormState();
}

class _AddressInfoFormState extends State<AddressInfoForm> {
  Address? _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.selectedCity;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Quốc tịch (mặc định Việt Nam, không cho đổi)
        IgnorePointer(
          ignoring: false, // disable toàn bộ thao tác
          child: BlocProvider(
            create: (context) => NationalityCubit(),
            child: ApiDropdown<Nationality, NationalityCubit, NationalityState>(
              selected: widget.selectedNationality,
              onChanged: (_) {}, // không cho đổi
              itemAsString: (item) => item.name,
              isLoading: (_) => false,
              isError: (_) => false,
              getErrorMessage: (_) => '',
              getItems: (_) => [
                Nationality(
                    id: 'c341e4b6-3426-4e40-ac06-6c0212f180b9',
                    name: 'Việt Nam')
              ],
              hintText: "Quốc tịch *",
              onSearch: (_) async => [
                Nationality(
                    id: 'c341e4b6-3426-4e40-ac06-6c0212f180b9',
                    name: 'Việt Nam')
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // City Dropdown
        BlocProvider<CityCubit>(
          create: (context) => CityCubit()
            ..fetchCity({"ParentId": widget.selectedNationality.id}),
          child: BlocBuilder<CityCubit, CityState>(
            builder: (context, state) {
              return ApiDropdown<Address, CityCubit, CityState>(
                selected: _selectedCity,
                onChanged: (val) {
                  setState(() => _selectedCity = val);
                  widget.onCityChanged(val);
                },
                itemAsString: (item) => item.name,
                isLoading: (state) => state is CityLoading,
                isError: (state) => state is CityError,
                getErrorMessage: (state) =>
                    state is CityError ? state.message : '',
                getItems: (state) => state is CityLoaded ? state.list : [],
                hintText: "Chọn thành phố *",
                onSearch: (filter) async {
                  await context
                      .read<CityCubit>()
                      .fetchCity({"ParentId": widget.selectedNationality.id});
                  final st = context.read<CityCubit>().state;
                  if (st is CityLoaded) return st.list;
                  return [];
                },
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // Address Dropdown (phụ thuộc City)
        BlocProvider<AddressCubit>(
          create: (context) => AddressCubit()
            ..fetchAddresses(
              _selectedCity != null ? {"ParentId": _selectedCity!.id} : {},
            ),
          child: BlocBuilder<AddressCubit, AddressState>(
            builder: (context, state) {
              return ApiDropdown<Address, AddressCubit, AddressState>(
                selected: widget.selectedAddress,
                onChanged: widget.onAddressChanged,
                itemAsString: (item) => item.name,
                isLoading: (state) => state is AddressLoading,
                isError: (state) => state is AddressError,
                getErrorMessage: (state) =>
                    state is AddressError ? state.message : '',
                getItems: (state) => state is AddressLoaded ? state.list : [],
                hintText: "Chọn xã/phường",
                onSearch: (filter) async {
                  if (_selectedCity == null) return [];
                  await context.read<AddressCubit>().fetchAddresses({
                    "ParentId": _selectedCity!.id,
                  });
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
          textController: widget.addressDetailController,
          label: 'Địa chỉ chi tiết (thôn/ngõ/ngách/số nhà)',
          prefixIcon:
              Icon(Icons.home_filled, size: 20, color: AppColors.primary),
          validator: (_) => null,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 14),

        // Ethnic Dropdown
        BlocProvider<EthnicCubit>(
          create: (_) => EthnicCubit()..fetchEthnics('Kinh'),
          child: BlocBuilder<EthnicCubit, EthnicState>(
            builder: (context, state) {
              return ApiDropdown<Ethnic, EthnicCubit, EthnicState>(
                selected: widget.selectedEthnic,
                onChanged: widget.onEthnicChanged,
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

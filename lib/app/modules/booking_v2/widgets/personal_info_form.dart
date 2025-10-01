import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/address_cubit.dart';
import '../../../../cubits/city_cubit.dart';
import '../../../../cubits/job_cubit.dart';
import '../../../../models/address_model.dart';
import '../../../../models/job_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/form_validator.dart';
import '../../../../widgets/dropdown/api_dropdown.dart';
import '../../../../widgets/text_field/input_text_field.dart';

class PersonalInfoForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController cccdController;
  final TextEditingController birthDateController;
  final TextEditingController ageController;
  final TextEditingController idIssueDateController;
  final String gender;
  final Function(String) onGenderChanged;
  final Function(BuildContext, TextEditingController) onDateSelect;
  final VoidCallback onQRScan;
  final Address? selectedIdIssuePlace;
  final Function(Address?) onIdIssuePlaceChanged;
  final Job? selectedJob;
  final Function(Job?) onJobChanged;

  const PersonalInfoForm({
    Key? key,
    required this.nameController,
    required this.phoneController,
    required this.cccdController,
    required this.birthDateController,
    required this.ageController,
    required this.idIssueDateController,
    required this.gender,
    required this.onGenderChanged,
    required this.onDateSelect,
    required this.onQRScan,
    required this.selectedIdIssuePlace,
    required this.onIdIssuePlaceChanged,
    required this.selectedJob,
    required this.onJobChanged,
  }) : super(key: key);

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    final green = Colors.green.shade700;
    return InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon:
          icon != null ? Icon(icon, size: 20, color: AppColors.primary) : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.primary, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade700, width: 2)),
      labelStyle: TextStyle(color: AppColors.primary.withOpacity(0.8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Vui lòng kiểm tra kỹ lại các thông tin khi quét'),

        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onQRScan,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Quét QR CCCD'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 14),
        InputTextField(
          textController: nameController,
          label: 'Họ & tên *',
          prefixIcon:
              const Icon(Icons.person, size: 20, color: AppColors.primary),
          validator: (v) => v == null || v.trim().isEmpty ? 'Bắt buộc' : null,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 14),

        InputTextField(
          textController: phoneController,
          label: 'Điện thoại *',
          prefixIcon:
              const Icon(Icons.phone, size: 20, color: AppColors.primary),
          keyboardType: TextInputType.phone,
          validator: FormValidator.validatePhone,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 14),

        InputTextField(
          textController: cccdController,
          label: 'CCCD *',
          prefixIcon:
              const Icon(Icons.badge, size: 20, color: AppColors.primary),
          keyboardType: TextInputType.number,
          validator: FormValidator.validateCCCD,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 14),

        GestureDetector(
          onTap: () => onDateSelect(context, idIssueDateController),
          child: AbsorbPointer(
            child: InputTextField(
              textController: idIssueDateController,
              label: 'Ngày cấp CCCD *',
              prefixIcon: const Icon(Icons.calendar_today,
                  size: 20, color: AppColors.primary),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Bắt buộc' : null,
              keyboardType: TextInputType.datetime,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ID Issue Place Dropdown
        BlocProvider<CityCubit>(
          create: (context) => CityCubit()..fetchCity({}),
          child: BlocBuilder<CityCubit, CityState>(
            builder: (context, state) {
              return ApiDropdown<Address, CityCubit, CityState>(
                selected: selectedIdIssuePlace,
                onChanged: onIdIssuePlaceChanged,
                itemAsString: (item) => item.name,
                isLoading: (state) => state is CityLoading,
                isError: (state) => state is CityError,
                getErrorMessage: (state) =>
                    state is CityError ? state.message : '',
                getItems: (state) => state is CityLoaded ? state.list : [],
                hintText: "Nơi cấp CCCD",
                onSearch: (filter) async {
                  await context.read<CityCubit>().fetchCity({});
                  final st = context.read<CityCubit>().state;
                  if (st is CityLoaded) return st.list;
                  return [];
                },
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        GestureDetector(
          onTap: () => onDateSelect(context, birthDateController),
          child: AbsorbPointer(
            child: InputTextField(
              textController: birthDateController,
              label: 'Ngày sinh (dd/MM/yyyy) *',
              prefixIcon:
                  const Icon(Icons.cake, size: 20, color: AppColors.primary),
              keyboardType: TextInputType.datetime,
              validator: FormValidator.validateDate,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: 14),

        InputTextField(
          textController: ageController,
          label: 'Tuổi *',
          prefixIcon:
              const Icon(Icons.timelapse, size: 20, color: AppColors.primary),
          keyboardType: TextInputType.number,
          validator: FormValidator.validateAge,
          textAlign: TextAlign.start,
          enabled: false, // Auto-calculated from birth date
        ),
        const SizedBox(height: 14),

        DropdownButtonFormField<String>(
          value: gender,
          decoration: _inputDecoration('Giới tính', icon: Icons.wc),
          items: const [
            DropdownMenuItem(value: 'Nam', child: Text('Nam')),
            DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
          ],
          onChanged: (v) => v != null ? onGenderChanged(v) : null,
        ),
        const SizedBox(height: 14),

        // Job Dropdown
        BlocProvider<JobCubit>(
          create: (_) => JobCubit()..fetchJobs(''),
          child: BlocBuilder<JobCubit, JobState>(
            builder: (context, state) {
              return ApiDropdown<Job, JobCubit, JobState>(
                selected: selectedJob,
                onChanged: onJobChanged,
                itemAsString: (item) => item.name,
                isLoading: (state) => state is JobLoading,
                isError: (state) => state is JobError,
                getErrorMessage: (state) =>
                    state is JobError ? state.message : '',
                getItems: (state) => state is JobLoaded ? state.list : [],
                hintText: "Chọn nghề nghiệp *",
                onSearch: (filter) async {
                  await context.read<JobCubit>().fetchJobs(filter);
                  final st = context.read<JobCubit>().state;
                  if (st is JobLoaded) return st.list;
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

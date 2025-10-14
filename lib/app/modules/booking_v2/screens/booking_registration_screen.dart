import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pstb/cubits/treatment_catalog_department_cubit.dart';
import 'package:pstb/models/treatment_catalog_department_model.dart';
import 'package:intl/intl.dart';
import '../../../../constant/config.dart';
import '../../../../cubits/treatment_catalog_cubit.dart';
import '../../../../models/clinic_room.dart';
import '../../../../models/treatment_catalog_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/shared_preferences_manager.dart';
import '../../../../widgets/dropdown/api_dropdown.dart';
import '../../../../widgets/dropdown/custom_dropdown_search.dart';
import '../../../../widgets/text_field/input_text_field.dart';
import '../cubit/create_request_cubit.dart';
import '../model/create_request_model.dart';

class BookingRegistrationScreen extends StatefulWidget {
  final Map<String, dynamic> patientInfo;

  const BookingRegistrationScreen({Key? key, required this.patientInfo})
      : super(key: key);

  @override
  State<BookingRegistrationScreen> createState() =>
      _BookingRegistrationScreenState();
}

class _BookingRegistrationScreenState extends State<BookingRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final f = NumberFormat('#,###', 'vi_VN');
  DateTime? scheduledAt;
  TreatmentCatalogModel? selectedTreatmentCatalog;
  TreatmentCatalogDepartmentModel?
      selectedTreatmentCatalogDepartment; // mặc định là khám thường
  String subjectType = 'Không BHYT'; // BHYT mặc định là "Không BHYT"
  //ClinicRoom? selectedRoom; // chọn phòng khám kiểu ClinicRoom
  final TextEditingController reasonCtrl = TextEditingController();
  String priority = 'Bình thường'; // mặc định
  String arrivalMethod = 'Tự đến'; // mặc định

  final green = AppColors.primary;
  bool isCanCreate = true;
  void _pickScheduledAt() async {
    final d = await showDatePicker(
      context: context,
      initialDate: scheduledAt ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d == null) return;

    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(scheduledAt ?? DateTime.now()),
    );
    if (t == null) return;
    setState(() {
      scheduledAt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    });
  }

  void _goNext() {
    if (!_formKey.currentState!.validate()) {
      _showWarning('Còn thiếu trường thông tin bắt buộc');
      return;
    }
    if (selectedTreatmentCatalog == null) {
      _showWarning('Vui lòng chọn loại khám');
      return;
    }
    if (selectedTreatmentCatalogDepartment == null) {
      _showWarning('Vui lòng chọn phòng khám');
      return;
    }
    if (scheduledAt == null) {
      _showWarning('Vui lòng chọn ngày giờ hẹn khám');
      return;
    }
    final formatted =
        '${scheduledAt!.hour.toString().padLeft(2, '0')}:${scheduledAt!.minute.toString().padLeft(2, '0')} '
        '${scheduledAt!.day.toString().padLeft(2, '0')}/${scheduledAt!.month.toString().padLeft(2, '0')}/${scheduledAt!.year}';
    final model = CreateRequestModel(
        // --- Dữ liệu từ màn 1 ---
        name: widget.patientInfo['name'] ?? '',
        cccd: widget.patientInfo['cccd'] ?? '',
        age: int.tryParse(widget.patientInfo['age']?.toString() ?? '5') ?? 5,
        gender: widget.patientInfo['gender'] == "Nam" ? 1 : 0,
        birthDate: widget.patientInfo['birthDate'] ?? '',
        jobName: widget.patientInfo['jobName'] ?? '',
        job: widget.patientInfo['job'] ?? '',
        addressDetail: widget.patientInfo['addressDetail'],
        phone: widget.patientInfo['phone'] ?? '',
        fatherName: widget.patientInfo['fatherName'] ?? '',
        motherName: widget.patientInfo['motherName'] ?? '',
        idIssueDate: widget.patientInfo['idIssueDate'] ?? '',
        idIssuePlace: widget.patientInfo['idIssuePlace'],
        nationalId: widget.patientInfo['nationalId'] ?? '',
        ethnic: widget.patientInfo['ethnic'] ?? '',
        provinceId: widget.patientInfo['provinceId'] ?? '',
        communeWardId: widget.patientInfo['communeWardId'] ?? '',
        nationalName: widget.patientInfo['nationalName'] ?? '',
        ethnicName: widget.patientInfo['ethnicName'] ?? '',
        provinceName: widget.patientInfo['provinceName'] ?? '',
        communeWardName: widget.patientInfo['communeWardName'] ?? '',
        // --- Dữ liệu từ màn 2 ---
        examTypeName: selectedTreatmentCatalog?.name,
        examTypeId: selectedTreatmentCatalog?.id.toString() ?? "",
        clinicRoomCode: selectedTreatmentCatalogDepartment?.code,
        clinicRoomName: selectedTreatmentCatalogDepartment?.name,
        reason: reasonCtrl.text.trim(),
        priority: priority,
        arrivalMethod: arrivalMethod,
        scheduledAt:
            scheduledAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        price: (selectedTreatmentCatalog?.price ?? -1).toString());

    final userPhone = GetIt.instance<SharedPreferencesManager>()
        .getString(AppConfig.SL_USERNAME);

    // Gọi Cubit để tạo request và lưu DB
    context.read<CreateRequestCubit>().submitRequest(model, userPhone ?? "");
    print("ok2");
  }

  void _showWarning(String message) {
    Flushbar(
      // Nội dung
      messageText: Row(
        children: [
          const Icon(Icons.warning, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 2), // thời gian hiển thị
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP, // nổi ở trên
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    ).show(context);
  }

  InputDecoration _inputDecoration(String label, {IconData? icon}) {
    return InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: icon != null ? Icon(icon, size: 20, color: green) : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: green, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade700, width: 2)),
      labelStyle: TextStyle(color: green.withOpacity(0.8)),
    );
  }

  void showCustomPopup(BuildContext context,
      {required bool success,
      required String title,
      String? description,
      int durationSeconds = 3}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.35,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: success ? AppColors.primary : Colors.redAccent,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(
                        success ? Icons.celebration : Icons.error_outline,
                        color: Colors.white,
                        size: 36,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Tự động ẩn
    Future.delayed(Duration(seconds: durationSeconds), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lọc phòng theo loại khám (requestType)

    const subjectTypeItems = ['Có BHYT', 'Không BHYT'];
    const priorityItems = ['Bình thường', 'Cấp cứu'];
    const arrivalMethodItems = ['Tự đến', 'Khám từ xa'];

    return BlocListener<CreateRequestCubit, CreateRequestState>(
      listener: (context, state) {
        if (state is CreateRequestLoading) {
          setState(() {
            isCanCreate = false;
          });
        }
        print(state);
        if (state is CreateRequestSuccess) {
          setState(() {
            isCanCreate = false;
          });
          showCustomPopup(
            context,
            success: true,
            title: 'Tạo yêu cầu thành công!',
            description:
                'Cảm ơn bạn! Yêu cầu đã được ghi nhận. Hãy đến khám đúng thời gian nhé.',
          );
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          });
        } else if (state is CreateRequestFailure) {
          showCustomPopup(
            context,
            success: false,
            title: 'Có lỗi xảy ra!',
            description: "Tạo yêu cầu khám không thành công",
          );
          setState(() {
            isCanCreate = true;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              size: 36,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Đăng ký & Yêu cầu',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: green,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "Loại khám *",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 4,
                ),
                // Loại khám
                BlocProvider<TreatmentCatalogCubit>(
                  create: (_) =>
                      TreatmentCatalogCubit()..fetchTreatmentCatalogs(),
                  child:
                      BlocBuilder<TreatmentCatalogCubit, TreatmentCatalogState>(
                    builder: (context, state) {
                      return ApiDropdown<TreatmentCatalogModel,
                          TreatmentCatalogCubit, TreatmentCatalogState>(
                        selected: selectedTreatmentCatalog,
                        onChanged: (item) {
                          setState(() {
                            selectedTreatmentCatalog = item;
                          });
                        },
                        itemAsString: (item) =>
                            "${item.name ?? ''} - ${item.price != null ? "${f.format(item.price ?? -1)} đ" : "Chưa có giá"} - ${item.patientClassificationName ?? ''}",
                        isLoading: (state) => state is TreatmentCatalogLoading,
                        isError: (state) => state is TreatmentCatalogError,
                        getErrorMessage: (state) =>
                            state is TreatmentCatalogError ? state.message : '',
                        getItems: (state) =>
                            state is TreatmentCatalogLoaded ? state.list : [],
                        hintText: "Loại khám *",
                        onSearch: (filter) async {
                          await context
                              .read<TreatmentCatalogCubit>()
                              .fetchTreatmentCatalogs();
                          final st =
                              context.read<TreatmentCatalogCubit>().state;
                          if (st is TreatmentCatalogLoaded) return st.list;
                          return [];
                        },
                      );
                    },
                  ),
                ),
                if (selectedTreatmentCatalog != null) ...[
                  const SizedBox(height: 14),
                  Text(
                    "Phòng khám *",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  BlocProvider<TreatmentCatalogDepartmentCubit>(
                    create: (_) => TreatmentCatalogDepartmentCubit()
                      ..fetchTreatmentCatalogDepartments(
                          selectedTreatmentCatalog!.id),
                    child: BlocBuilder<TreatmentCatalogDepartmentCubit,
                        TreatmentCatalogDepartmentState>(
                      builder: (context, state) {
                        return ApiDropdown<
                            TreatmentCatalogDepartmentModel,
                            TreatmentCatalogDepartmentCubit,
                            TreatmentCatalogDepartmentState>(
                          selected: selectedTreatmentCatalogDepartment,
                          onChanged: (item) {
                            selectedTreatmentCatalogDepartment = item;
                          },
                          itemAsString: (item) => item.name ?? "",
                          isLoading: (state) =>
                              state is TreatmentCatalogLoading,
                          isError: (state) => state is TreatmentCatalogError,
                          getErrorMessage: (state) =>
                              state is TreatmentCatalogDepartmentError
                                  ? state.message
                                  : '',
                          getItems: (state) =>
                              state is TreatmentCatalogDepartmentLoaded
                                  ? state.list
                                  : [],
                          hintText: "Phòng khám",
                          onSearch: (filter) async {
                            await context
                                .read<TreatmentCatalogDepartmentCubit>()
                                .fetchTreatmentCatalogDepartments(
                                    selectedTreatmentCatalog!.id);
                            final st = context
                                .read<TreatmentCatalogDepartmentCubit>()
                                .state;
                            if (st is TreatmentCatalogDepartmentLoaded)
                              return st.list;
                            return [];
                          },
                        );
                      },
                    ),
                  ),
                ],

                const SizedBox(height: 14),
                const Text(
                  'BHYT *',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                CustomDropdown<String>(
                  label: 'BHYT *',
                  items: subjectTypeItems,
                  selectedItem: subjectType,
                  itemLabel: (e) => e,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      subjectType = v;
                    });
                  },
                  enabled: false,
                ),

                if (subjectType == 'Có BHYT') ...[
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Phải đến nơi và xuất trình giấy tờ khi đến khám.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],

                const SizedBox(height: 18),

                InkWell(
                  onTap: _pickScheduledAt,
                  child: InputDecorator(
                    decoration: _inputDecoration('Ngày giờ hẹn khám *'),
                    child: Text(
                      scheduledAt == null
                          ? 'Chọn ngày giờ'
                          : '${scheduledAt!.day.toString().padLeft(2, '0')}/${scheduledAt!.month.toString().padLeft(2, '0')}/${scheduledAt!.year} '
                              '${scheduledAt!.hour.toString().padLeft(2, '0')}:${scheduledAt!.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: scheduledAt == null ? Colors.grey : green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Lý do đến khám *',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                InputTextField(
                  label: 'Lý do đến khám',
                  textController: reasonCtrl,
                  maxLine: 3,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Bắt buộc' : null,
                  textAlign: TextAlign.start,
                ),

                const SizedBox(height: 14),
                const Text(
                  'Ưu tiên',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                CustomDropdown<String>(
                  label: 'Ưu tiên',
                  items: priorityItems,
                  selectedItem: priority,
                  itemLabel: (e) => e,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      priority = v;
                    });
                  },
                  enabled: false,
                ),

                const SizedBox(height: 14),
                const Text(
                  'Hình thức đến',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 6),
                CustomDropdown<String>(
                  label: 'Hình thức đến',
                  items: arrivalMethodItems,
                  selectedItem: arrivalMethod,
                  itemLabel: (e) => e,
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() {
                      arrivalMethod = v;
                    });
                  },
                  enabled: false,
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: !isCanCreate ? null : _goNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Tiếp tục',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

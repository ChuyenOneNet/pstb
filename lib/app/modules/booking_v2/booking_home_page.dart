import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pstb/app/modules/booking_v2/qr_scanner_screen.dart';
import 'package:pstb/app/modules/booking_v2/widgets/address_info_form.dart';
import 'package:pstb/app/modules/booking_v2/widgets/parent_info_form.dart';
import 'package:pstb/app/modules/booking_v2/widgets/patient_type_selector.dart';
import 'package:pstb/app/modules/booking_v2/widgets/personal_info_form.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubits/address_cubit.dart';
import '../../../cubits/ethnic_cubit.dart';
import '../../../cubits/job_cubit.dart';
import '../../../cubits/nationality_cubit.dart';
import '../../../models/address_model.dart';
import '../../../models/ethnic_model.dart';
import '../../../models/job_model.dart';
import '../../../models/nationality_model.dart';
import '../../../utils/age_calculator.dart';
import '../../../utils/colors.dart';
import 'package:pstb/app/modules/booking_v2/screens/booking_registration_screen.dart';
import '../../../utils/form_validator.dart';
import '../../../utils/qr_processor.dart';

class BookingPatientScreen extends StatefulWidget {
  const BookingPatientScreen({Key? key}) : super(key: key);

  @override
  State<BookingPatientScreen> createState() => _BookingPatientScreenState();
}

class _BookingPatientScreenState extends State<BookingPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController cccdCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  final TextEditingController birthDateCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController fatherNameCtrl = TextEditingController();
  final TextEditingController motherNameCtrl = TextEditingController();
  final TextEditingController idIssueDateCtrl = TextEditingController();
  final TextEditingController addressDetailCtrl = TextEditingController();

  // State variables
  String patientType = 'Cá nhân';
  String gender = 'Nam';
  Job? selectedJob;
  Nationality selectedNationality = Nationality(id: 'vi', name: 'Việt Nam');
  Ethnic selectedEthnic = Ethnic(id: '1', name: 'Kinh');
  Address? selectedAddressModel;
  Address? selectedIdIssuePlace;

  @override
  void initState() {
    super.initState();
    if (patientType == 'Cá nhân') {
      _loadPersonalInfo();
    }

    // Add listener to birth date controller for automatic age calculation
    birthDateCtrl.addListener(_onBirthDateChanged);
  }

  @override
  void dispose() {
    birthDateCtrl.removeListener(_onBirthDateChanged);
    // Dispose all controllers
    nameCtrl.dispose();
    cccdCtrl.dispose();
    ageCtrl.dispose();
    birthDateCtrl.dispose();
    phoneCtrl.dispose();
    fatherNameCtrl.dispose();
    motherNameCtrl.dispose();
    idIssueDateCtrl.dispose();
    addressDetailCtrl.dispose();
    super.dispose();
  }

  void _onBirthDateChanged() {
    if (birthDateCtrl.text.isNotEmpty) {
      final age = AgeCalculator.calculateAge(birthDateCtrl.text);
      if (age > 0) {
        ageCtrl.text = age.toString();
      }
    }
  }

  Future<void> _loadPersonalInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameCtrl.text = prefs.getString('name') ?? '';
      cccdCtrl.text = prefs.getString('cccd') ?? '';
      final rawBirthDate = prefs.getString('birthDate') ?? '';
      if (rawBirthDate.isNotEmpty) {
        final parts = rawBirthDate.split(' ');
        birthDateCtrl.text = parts[0];
        // Age will be calculated automatically by the listener
      }
      final rawGender = prefs.getString('gender') ?? 'm';
      gender = _mapGenderFromPrefs(rawGender);
      phoneCtrl.text = prefs.getString('phone') ?? '';
      addressDetailCtrl.text = prefs.getString('addressDetail') ?? '';
    });
  }

  String _mapGenderFromPrefs(String g) {
    switch (g.toLowerCase()) {
      case 'm':
        return 'Nam';
      case 'f':
        return 'Nữ';
      default:
        return 'Nam';
    }
  }

  void _clearForm() {
    setState(() {
      nameCtrl.clear();
      cccdCtrl.clear();
      ageCtrl.clear();
      birthDateCtrl.clear();
      phoneCtrl.clear();
      fatherNameCtrl.clear();
      motherNameCtrl.clear();
      idIssueDateCtrl.clear();
      selectedIdIssuePlace = null;
      addressDetailCtrl.clear();

      gender = 'Nam';
      selectedJob = null;
      selectedNationality = Nationality(id: 'vi', name: 'Việt Nam');
      selectedEthnic = Ethnic(id: '1', name: 'Kinh');
      selectedAddressModel = null;
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    try {
      if (controller.text.isNotEmpty) {
        initialDate = DateFormat('dd/MM/yyyy').parse(controller.text);
      }
    } catch (_) {}

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      controller.text = formattedDate;
      setState(() {});
    }
  }

  Future<void> _scanQRCode() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerScreen(
          onQRScanned: (String qrData) {
            QRProcessor.processQRData(
              qrData,
              onSuccess: (data) {
                setState(() {
                  cccdCtrl.text = data['cccd'] ?? '';
                  nameCtrl.text = data['name'] ?? '';
                  birthDateCtrl.text = data['birthDate'] ?? '';
                  addressDetailCtrl.text = data['address'] ?? '';
                  gender = data['gender'] ?? 'Nam';
                  idIssueDateCtrl.text = data['issueDate'] ?? '';
                });
              },
              onError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi đọc mã QR: $error')),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onNext() {
    if (!FormValidator.validateForm(
      formKey: _formKey,
      cccd: cccdCtrl.text,
      selectedAddress: selectedAddressModel,
      idIssueDate: idIssueDateCtrl.text,
      selectedJob: selectedJob,
      age: ageCtrl.text,
      fatherName: fatherNameCtrl.text,
      motherName: motherNameCtrl.text,
      onWarning: _showWarning,
    )) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingRegistrationScreen(
          patientInfo: {
            'name': nameCtrl.text.trim(),
            'cccd': cccdCtrl.text.trim(),
            'age': ageCtrl.text.trim(),
            'gender': gender,
            'birthDate': birthDateCtrl.text.trim(),
            'job': selectedJob!.id,
            'address': selectedAddressModel?.id,
            'addressDetail': addressDetailCtrl.text.trim(),
            'phone': phoneCtrl.text.trim(),
            'fatherName': fatherNameCtrl.text.trim(),
            'motherName': motherNameCtrl.text.trim(),
            'idIssueDate': idIssueDateCtrl.text.trim(),
            'idIssuePlace': selectedIdIssuePlace?.id ?? null,
            'nationalId': selectedNationality.id,
            'ethnic': selectedEthnic.id,
          },
        ),
      ),
    );
  }

  void _showWarning(String message) {
    Flushbar(
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
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    final green = AppColors.primary;

    return Scaffold(
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
          'Nhập thông tin cá nhân',
          style: TextStyle(color: Colors.white),
        ),
        //   backgroundColor: green,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                PatientTypeSelector(
                  patientType: patientType,
                  onChanged: (type) async {
                    setState(() => patientType = type);
                    if (type == 'Cá nhân') {
                      await _loadPersonalInfo();
                    } else {
                      _clearForm();
                    }
                  },
                ),
                const SizedBox(height: 14),
                PersonalInfoForm(
                  nameController: nameCtrl,
                  phoneController: phoneCtrl,
                  cccdController: cccdCtrl,
                  birthDateController: birthDateCtrl,
                  ageController: ageCtrl,
                  idIssueDateController: idIssueDateCtrl,
                  gender: gender,
                  onGenderChanged: (value) => setState(() => gender = value),
                  onDateSelect: _selectDate,
                  onQRScan: _scanQRCode,
                  selectedIdIssuePlace: selectedIdIssuePlace,
                  onIdIssuePlaceChanged: (value) =>
                      setState(() => selectedIdIssuePlace = value),
                  selectedJob: selectedJob,
                  onJobChanged: (value) => setState(() => selectedJob = value),
                ),
                const SizedBox(height: 14),
                AddressInfoForm(
                  addressDetailController: addressDetailCtrl,
                  selectedAddress: selectedAddressModel,
                  onAddressChanged: (value) =>
                      setState(() => selectedAddressModel = value),
                  selectedNationality: selectedNationality,
                  onNationalityChanged: (value) => setState(
                      () => selectedNationality = value ?? selectedNationality),
                  selectedEthnic: selectedEthnic,
                  onEthnicChanged: (value) =>
                      setState(() => selectedEthnic = value ?? selectedEthnic),
                ),
                const SizedBox(height: 14),
                ParentInfoForm(
                  fatherNameController: fatherNameCtrl,
                  motherNameController: motherNameCtrl,
                  ageController: ageCtrl,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Tiếp tục',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

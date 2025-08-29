// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pstb/app/modules/nurse_page/nurse_searching_store.dart';
// import 'package:pstb/app/modules/nurse_page/qr_scanner/qr_code_store.dart';
// import 'package:pstb/app/modules/nurse_page/widgets/button_confirm_nursing_widget.dart';
// import 'package:pstb/utils/main.dart';
// import 'package:pstb/widgets/stateless/stateless_widget.dart';
// import 'widgets/nurse_information.dart';
//
// class NurseSearchingPage extends StatefulWidget {
//   const NurseSearchingPage({Key? key}) : super(key: key);
//
//   @override
//   State<NurseSearchingPage> createState() => _NurseSearchingPageState();
// }
//
// class _NurseSearchingPageState extends State<NurseSearchingPage> {
//   final _nurseStore = Modular.get<NurseSearchingStore>();
//   final _form = GlobalKey<FormState>();
//   late TextEditingController _controllerCodeNursing;
//   late TextEditingController _controllerInfoPaper;
//   late TextEditingController _controllerNamePaper;
//   late TextEditingController _patientEditingController;
//
//   @override
//   void initState() {
//     _controllerInfoPaper = TextEditingController()
//       ..addListener(() {
//         _nurseStore.descriptionPaper = _controllerInfoPaper.text;
//       });
//     _patientEditingController =
//         TextEditingController(text: _nurseStore.codePatient)
//           ..addListener(() {
//             _nurseStore.codePatient = _patientEditingController.text;
//           });
//     _controllerNamePaper = TextEditingController()
//       ..addListener(() {
//         _nurseStore.nameFile = _controllerNamePaper.text;
//       });
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
//       await _nurseStore.initState();
//       _controllerCodeNursing =
//           TextEditingController(text: _nurseStore.codeNurse);
//       if (_nurseStore.errorMessage != null) {
//         AppSnackBar.show(
//             context, AppSnackBarType.Error, _nurseStore.errorMessage);
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controllerCodeNursing.dispose();
//     _controllerInfoPaper.dispose();
//     _controllerNamePaper.dispose();
//     _patientEditingController.dispose();
//     Modular.dispose<NurseSearchingStore>();
//     Modular.dispose<QRCodeStore>();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (FocusScope.of(context).hasFocus) {
//           FocusScope.of(context).unfocus();
//         }
//       },
//       child: Observer(builder: (context) {
//         return Scaffold(
//           appBar: CustomAppBar(
//             onBack: () {
//               if (_patientEditingController.text.isNotEmpty) {
//                 _patientEditingController.clear();
//                 _nurseStore.backInitStateNursingPage();
//                 return;
//               }
//               Modular.to.pop();
//             },
//             title: (!_nurseStore.isActiveInputHealthCare &&
//                     !_nurseStore.isActivePaper)
//                 ? l10n(context).nurse_page
//                 : _nurseStore.isActiveInputHealthCare
//                     ? l10n(context).input_hint_take_care_of
//                     : l10n(context).paper_healthcare,
//             actionIcon: (!_nurseStore.isActiveInputHealthCare &&
//                     !_nurseStore.isActivePaper)
//                 ? const SizedBox()
//                 : PopupMenuButton(
//                     itemBuilder: (context) {
//                       return [
//                         if (!_nurseStore.isActiveInputHealthCare)
//                           PopupMenuItem<int>(
//                             value: 0,
//                             child: Text(l10n(context).input_hint_take_care_of),
//                           ),
//                         if (_nurseStore.isActiveInputHealthCare)
//                           PopupMenuItem<int>(
//                             value: 1,
//                             child: Text(l10n(context).paper_healthcare),
//                           ),
//                       ];
//                     },
//                     onSelected: _nurseStore.onActionSelectedPopup),
//             actionFunc: () {},
//           ),
//           body: Padding(
//             padding: Styles.defaultPageMargin,
//             child: Form(
//               key: _form,
//               child: ListView(
//                 physics: const ClampingScrollPhysics(),
//                 padding: EdgeInsets.only(
//                     top: 16,
//                     bottom: MediaQuery.of(context).viewPadding.bottom + 12),
//                 children: [
//                   Text(
//                     'Thời gian: ${_nurseStore.dateTime}',
//                     style: Styles.titleItem,
//                   ),
//                   NurseWidget(
//                     nameEditingController: _controllerNamePaper,
//                     patientEditingController: _patientEditingController,
//                     controller: _controllerInfoPaper,
//                   ),
//                   if (!_nurseStore.isHiddenButton)
//                     ButtonConfirmNursingWidget(
//                         controllerPatient: _patientEditingController,
//                         form: _form,
//                         nurseStore: _nurseStore,
//                         controllerInfoPaper: _controllerInfoPaper,
//                         controllerNamePaper: _controllerNamePaper),
//                   if (!_nurseStore.isActivePatient)
//                     SvgPicture.asset(IconEnums.healthTeam)
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

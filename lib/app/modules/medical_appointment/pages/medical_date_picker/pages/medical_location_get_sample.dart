// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pstb/app/modules/prescription/pages/get_prescription/pages/setting_delivery_location/address_search.dart';
// import 'package:pstb/app/modules/prescription/pages/get_prescription/pages/setting_delivery_location/place_service.dart';
// import 'package:pstb/responsitory/userInfo/user_info_model.dart';
// import 'package:pstb/utils/main.dart';
// import 'package:pstb/widgets/stateful/stateful_widget.dart';
// import 'package:pstb/widgets/stateless/stateless_widget.dart';
// import 'package:uuid/uuid.dart';
// import '../medical_store.dart';
//
// class MedicalLocationGetSample extends StatefulWidget {
//   const MedicalLocationGetSample({Key? key}) : super(key: key);
//   @override
//   _MedicalLocationGetSampleState createState() =>
//       _MedicalLocationGetSampleState();
// }
//
// class _MedicalLocationGetSampleState extends State<MedicalLocationGetSample> {
//   final MedicalStore _controller = Modular.get<MedicalStore>();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     _controller.getUserInfo();
//     super.initState();
//   }
//
//   void onSearch(String value) {}
//
//   void onChooseLocation(UserAddress value) {
//     _controller.onChangeLocation(value);
//     Modular.to.pop();
//   }
//
//   Future<void> _handlePressButton() async {
//     final sessionToken = Uuid().v4();
//     final Suggestion? result = await showSearch(
//       context: context,
//       delegate: AddressSearch(sessionToken),
//     );
//     onChooseLocation(UserAddress(address: result!.description));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         backgroundColor: AppColors.newbg900,
//         title: l10n(context)!.medical_location_get_sample_title,
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: widthConvert(context, 375),
//             color: AppColors.background,
//             child: Form(
//               key: _formKey,
//               child: TextFormField(
//                 readOnly: true,
//                 onTap: () => _handlePressButton(),
//                 decoration: InputDecoration(
//                   hintText: l10n(context)!.search,
//                   prefixIcon: Padding(
//                     padding: EdgeInsets.only(bottom: 6, left: 12, right: 12),
//                     child: SvgPicture.asset(
//                       IconEnums.mapPin,
//                       width: 12,
//                       height: 12,
//                       fit: BoxFit.contain,
//                       color: AppColors.grayLight,
//                     ),
//                   ),
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: AppColors.neutral300),
//                   ),
//                 ),
//                 onFieldSubmitted: onSearch,
//               ),
//             ),
//           ),
//           Expanded(
//               child: Column(
//             children: [
//               Observer(
//                 builder: (context) => _controller.listHome.length > 0
//                     ? Wrap(
//                         children: List.generate(
//                           _controller.listHome.length,
//                           (index) {
//                             return Container(
//                               color: AppColors.background,
//                               child: Container(
//                                 height: 57,
//                                 margin: EdgeInsets.symmetric(horizontal: 16),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         top: BorderSide(
//                                             width: 1,
//                                             color: AppColors.neutral300))),
//                                 child: TouchableOpacity(
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         margin: EdgeInsets.only(right: 16),
//                                         child: SvgPicture.asset(
//                                           IconEnums.locationTarget2,
//                                           color: AppColors.primary500,
//                                         ),
//                                       ),
//                                       Text(
//                                         l10n(context)!
//                                             .prescription_setting_home,
//                                         style: Styles.bodyBold,
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(
//                                             left: 4, right: 4, bottom: 12),
//                                         child: Text(
//                                           ".",
//                                           style: Styles.bodyBold
//                                               .copyWith(fontSize: 24),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           Constants.showAddress([
//                                             _controller.listHome[index].address,
//                                             _controller
//                                                 .listHome[index].district,
//                                             _controller.listHome[index].province
//                                           ]),
//                                           style: Styles.bodyRegular,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   onTap: () {
//                                     onChooseLocation(
//                                         _controller.listHome[index]);
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : SizedBox(),
//               ),
//               Observer(
//                 builder: (context) => _controller.listCompany.length > 0
//                     ? Wrap(
//                         children: List.generate(
//                           _controller.listCompany.length,
//                           (index) {
//                             return Container(
//                               color: AppColors.background,
//                               child: Container(
//                                 height: 57,
//                                 margin: EdgeInsets.symmetric(horizontal: 16),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         top: BorderSide(
//                                             width: 1,
//                                             color: AppColors.neutral300))),
//                                 child: TouchableOpacity(
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         margin: EdgeInsets.only(right: 16),
//                                         child: SvgPicture.asset(
//                                           IconEnums.locationTarget21,
//                                           color: AppColors.primary500,
//                                         ),
//                                       ),
//                                       Text(
//                                         l10n(context)!
//                                             .prescription_setting_saved,
//                                         style: Styles.bodyBold,
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.only(
//                                             left: 4, right: 4, bottom: 12),
//                                         child: Text(
//                                           ".",
//                                           style: Styles.bodyBold
//                                               .copyWith(fontSize: 24),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           Constants.showAddress([
//                                             _controller
//                                                 .listCompany[index].address,
//                                             _controller
//                                                 .listCompany[index].district,
//                                             _controller
//                                                 .listCompany[index].province
//                                           ]),
//                                           style: Styles.bodyRegular,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   onTap: () {
//                                     onChooseLocation(
//                                         _controller.listCompany[index]);
//                                   },
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : SizedBox(),
//               ),
//             ],
//           ))
//         ],
//       ),
//     );
//   }
// }

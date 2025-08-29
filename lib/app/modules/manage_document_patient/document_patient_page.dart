import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/modules/manage_document_patient/document_patient_store.dart';
import 'package:pstb/app/modules/manage_document_patient/widget/list_document_patient.dart';
import 'package:pstb/widgets/stateless/divider_custom_widget.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/colors.dart';
import '../../../utils/helper.dart';
import '../../../utils/routes.dart';
import '../../../utils/styles.dart';
import '../../route_guard.dart';
import '../../user_app_store.dart';
import '../auth_guard/auth_guard_page.dart';
import '../nurse_page/electronic_signature/widgets/loading_signature_widget.dart';

class DocumentPatientPage extends StatefulWidget {
  DocumentPatientPage({Key? key}) : super(key: key);

  @override
  State<DocumentPatientPage> createState() => _DocumentPatientPageState();
}

class _DocumentPatientPageState extends State<DocumentPatientPage> {
  final DocumentPatientStore documentPatientStore =
      Modular.get<DocumentPatientStore>();
  final UserGuard _userGuard = UserGuard();
  late ScrollController _scrollController;
  late String codeNurse = '';

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadMoreItems);
    // TODO: implement initState
    checkLogin();
    documentPatientStore.getHeaderForPdf();
    print("init state");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(_loadMoreItems);
    documentPatientStore.isShowCheckedItem = false;
    super.dispose();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await documentPatientStore.loadMoreSignature();
    }
  }

  void checkLogin() async {
    UserStatus isLogin = await _userGuard.canActivate();
    if (isLogin == UserStatus.Signed) {
      await documentPatientStore.getSigner();
    }
    documentPatientStore.setIsLogin(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Quản lý tài liệu ký số',
          isBack: true,
          actionIcon: Text(
            'Huỷ',
            style: Styles.titleItem.copyWith(color: AppColors.primary),
          ),
          actionFunc: documentPatientStore.isShowCheckedItem
              ? () async {
                  documentPatientStore.isShowCheckedItem = false;
                  documentPatientStore.selectedDocuments = List.generate(
                      documentPatientStore.listESM.length, (index) => false);
                  documentPatientStore.documents.clear();
                  documentPatientStore.ids.clear();
                }
              : null,
          leading: documentPatientStore.isShowCheckedItem
              ? InkWell(
                  onTap: () {
                    documentPatientStore.onChooseAllDocument(
                        documentPatientStore.documentTypeCode!);
                  },
                  child: const Center(
                      child: Text(
                    'Tất cả',
                    textAlign: TextAlign.center,
                  )))
              : InkWell(
                  onTap: () {
                    Modular.to.pop();
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    size: 36,
                    color: AppColors.background,
                  ),
                ),
        ),
        body: Observer(builder: (context) {
          return documentPatientStore.isLogin == UserStatus.Signed
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Icon(Icons.person,
                      //         color: Colors.black.withOpacity(0.4)),
                      //     const SizedBox(
                      //       width: 4.0,
                      //     ),
                      //     Text(
                      //       _userAppStore.user.fullName ?? "",
                      //       style: Styles.titleItem.copyWith(
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 4.0,
                      // ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.call,
                      //         color: Colors.black.withOpacity(0.4)),
                      //     const SizedBox(
                      //       width: 4.0,
                      //     ),
                      //     Text(
                      //       _userAppStore.user.phone ?? "",
                      //       style: Styles.titleItem.copyWith(
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 4.0,
                      // ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.email,
                      //         color: Colors.black.withOpacity(0.4)),
                      //     const SizedBox(
                      //       width: 4.0,
                      //     ),
                      //     Text(
                      //       (_userAppStore.user.email == null ||
                      //               _userAppStore.user.email!.isEmpty)
                      //           ? "Email"
                      //           : _userAppStore.user.email!,
                      //       style: Styles.titleItem.copyWith(
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const DividerCustomWidget(),
                      Expanded(
                        child: Observer(builder: (context) {
                          if (documentPatientStore.isLoading) {
                            return const LoadingSignatureWidget();
                          }
                          return documentPatientStore.listESM.isNotEmpty
                              ? ListDocumentPatient(
                                  scrollController: _scrollController,
                                  documentPatientStore: documentPatientStore,
                                )
                              : Center(
                                  child: Text(
                                    'Không có dữ liệu.',
                                    style: Styles.content
                                        .copyWith(color: AppColors.black),
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                )
              : AuthGuardPage();
        }),
        bottomNavigationBar: documentPatientStore.isShowCheckedItem
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      child: AppButton(
                        title: 'Thực hiện ký',
                        onPressed: () async {
                          if (documentPatientStore.ids.isEmpty) {
                            Fluttertoast.showToast(
                                msg: 'Vui lòng chọn tài liệu cần được ký.');
                            return;
                          }
                          await documentPatientStore.prepareSignDocuments(
                              documentPatientStore.ids,
                              documentPatientStore.documentTypeCode!);
                          if (documentPatientStore.prepareSign == true) {
                            Modular.to.pushNamed(AppRoutes.otpdocumentPatient,
                                arguments: {
                                  'transactionId':
                                      documentPatientStore.transactionId,
                                  'documents': documentPatientStore.documents,
                                });
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            : null,
      );
    });
  }
}

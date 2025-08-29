import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pstb/app/models/command_model.dart';
import 'package:pstb/app/models/nurse_model.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/command/command_store.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/health_care_patient/healthcare_store.dart';
import 'package:pstb/app/modules/nurse_page/widgets/input_field_patient_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/item_text_row.dart';

class CommandAndCareWidget extends StatelessWidget {
  CommandAndCareWidget(
      {Key? key, required this.commands, required this.healthCares})
      : super(key: key);
  final List<CommandModel> commands;
  final List<NurseModel> healthCares;
  final healthCareStore = Modular.get<HealthCareStore>();
  final commandStore = Modular.get<CommandStore>();

  @override
  Widget build(BuildContext context) {
    if (commands.isEmpty && healthCares.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text("Chưa có chỉ định y lệnh/chăm sóc"),
      ));
    }
    if (commands.isEmpty) {
      return ExpansionTile(
        title: Text(
          Constants.therapy[1],
        ),
        trailing: const SizedBox(),
        leading: Container(
          color: AppColors.primary,
          child: const Icon(
            Icons.add,
            color: AppColors.background,
          ),
        ),
        children: List.generate(
            healthCares.length,
            (subIndex) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColors.lightSilver.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    onTap: () async {
                      healthCareStore.id = healthCares[subIndex].id ?? "";
                      if (healthCareStore.id!.isNotEmpty) {
                        await healthCareStore.getDetailHealthCare();
                        showDialogHealthyCare(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Không có thông tin chăm sóc',
                          backgroundColor: AppColors.error500,
                        );
                      }
                      // Modular.to.pushNamed(AppRoutes.takeCare, arguments: {
                      //   "id": healthCares[subIndex].id,
                      // });
                    },
                    title: Text(
                      healthCares[subIndex].time ?? "",
                      style: Styles.subtitleSmallest,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                )),
      );
    }
    if (healthCares.isEmpty) {
      return ExpansionTile(
        title: Text(
          Constants.therapy[0],
        ),
        trailing: const SizedBox(),
        leading: Container(
          color: AppColors.primary,
          child: const Icon(
            Icons.add,
            color: AppColors.background,
          ),
        ),
        children: List.generate(
            commands.length,
            (subIndex) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColors.lightSilver.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    onTap: () async {
                      commandStore.id = commands[subIndex].id;
                      await commandStore.getDetailTreatmentCommand();
                      showDialogCommand(context);
                      // Modular.to.pushNamed(AppRoutes.command, arguments: {
                      //   "id": commands[subIndex].id,
                      // });
                    },
                    title: Text(
                      commands[subIndex].time ?? "",
                      style: Styles.subtitleSmallest,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                )),
      );
    }
    return Column(
      children: List.generate(
        Constants.therapy.length,
        (index) => ExpansionTile(
          title: Text(
            Constants.therapy[index],
          ),
          trailing: const SizedBox(),
          leading: Container(
            color: AppColors.primary,
            child: const Icon(
              Icons.add,
              color: AppColors.background,
            ),
          ),
          children: List.generate(
              index == 0 ? commands.length : healthCares.length,
              (subIndex) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: AppColors.lightSilver.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      onTap: () async {
                        if (index == 0) {
                          commandStore.id = commands[subIndex].id;
                          await commandStore.getDetailTreatmentCommand();
                          showDialogCommand(context);
                        } else {
                          healthCareStore.id = healthCares[subIndex].id ?? "";
                          await healthCareStore.getDetailHealthCare();
                          showDialogHealthyCare(context);
                        }
                      },
                      title: Text(
                        index == 0
                            ? commands[subIndex].time ?? ""
                            : healthCares[subIndex].time ?? "",
                        style: Styles.subtitleSmallest,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  )),
        ),
      ),
    );
  }

  Future<void> showDialogHealthyCare(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Thông tin chăm sóc',
                      style: Styles.titleItem
                          .copyWith(color: AppColors.primary, fontSize: 18.0)),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.lightSilver,
                      ),
                      child: SvgPicture.asset(
                        IconEnums.close,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: AppColors.primary,
              ),
              Column(
                children: [
                  ItemTextRow(
                      title: "Nhịp thở (lần/phút): ",
                      content:
                          healthCareStore.nurseModel?.breathing.toString() ??
                              ""),
                  ItemTextRow(
                      title: "Nhiệt độ (\u{2103}): ",
                      content:
                          healthCareStore.nurseModel?.temperature.toString() ??
                              ""),
                  ItemTextRow(
                      title: "Huyết áp Max (mmHg): ",
                      content:
                          healthCareStore.nurseModel?.bloodPressureMax ?? ""),
                  ItemTextRow(
                      title: "Huyết áp Min (mmHg): ",
                      content:
                          healthCareStore.nurseModel?.bloodPressureMin ?? ""),
                  const ItemTextRow(title: "Mạch (lần/phút): ", content: ""),
                  ItemTextRow(
                      title: "Diễn biến: ",
                      content: healthCareStore.nurseModel?.disease ?? ""),
                  ItemTextRow(
                      title: "Chăm sóc: ",
                      content: healthCareStore.nurseModel?.progression ?? ""),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Modular.to.pushNamed(AppRoutes.createHealthCare);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Icon(
                          Icons.add,
                          size: 28,
                          color: AppColors.background,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showDialogCommand(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Thông tin y lệnh',
                      style: Styles.titleItem
                          .copyWith(color: AppColors.primary, fontSize: 18.0)),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: AppColors.lightSilver,
                      ),
                      child: SvgPicture.asset(
                        IconEnums.close,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: AppColors.primary,
              ),
              Column(
                children: [
                  ItemTextRow(
                      title: "Thời gian: ",
                      content: commandStore.commandData?.createDatetime ?? ""),
                  ItemTextRow(
                      title: "Bác sĩ: ",
                      content: commandStore.commandData?.nameDoctor ?? ""),
                  ItemTextRow(
                      title: "Diễn biến: ",
                      content: commandStore.commandData?.progression ?? ""),
                  ItemTextRow(
                      title: "Chế độ chăm sóc: ",
                      content: commandStore.commandData?.careMode ?? ""),
                  ItemTextRow(
                      title: "Cấp độ chăm sóc: ",
                      content: commandStore.commandData?.careLevel ?? ""),
                  ItemTextRow(
                      title: "Chế độ dinh dưỡng: ",
                      content: commandStore.commandData?.nutrition ?? ""),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Chỉ định dịch vụ kỹ thuật: ',
                          style: Styles.content,
                        ),
                      ],
                    ),
                  ),
                  if (commandStore.commandData?.service != null &&
                      commandStore.commandData!.service!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4.0,
                      ),
                      child: Column(
                        children: List.generate(
                            commandStore.commandData!.service!.length,
                            (index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "     ${index+1}. ${commandStore.commandData?.service![index].sevText}",
                                        style: Styles.content.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Chỉ định thuốc: ',
                          style: Styles.content,
                        ),
                      ],
                    ),
                  ),
                  if (commandStore.commandData?.medicines != null &&
                      commandStore.commandData!.medicines!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) {
                            final medicines =
                                commandStore.commandData!.medicines![index];
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  border:
                                      Border.all(color: AppColors.lightSilver)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: Text(
                                      '${index + 1}',
                                    ),
                                    radius: 14.0,
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text("Tên thuốc:"),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${medicines.medText}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text("Số lượng:"),
                                      ),
                                      Text(
                                        "${medicines.medNumber}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text("Đường dùng:"),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${medicines.medUnit}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text("Cách dùng:"),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${medicines.medUse}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: 2),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

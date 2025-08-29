import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/models/command_model.dart';
import 'package:pstb/app/modules/nurse_page/therapy_information/detail_therapy/command/command_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/app_bar.dart';
import 'package:pstb/widgets/stateless/app_circle_loading.dart';

class CommandPage extends StatefulWidget {
  const CommandPage({Key? key}) : super(key: key);

  @override
  State<CommandPage> createState() => _CommandPageState();
}

class _CommandPageState extends State<CommandPage> {
  final store = Modular.get<CommandStore>();
  @override
  void initState() {
    store.id = Modular.args?.data["id"];
    store.getDetailTreatmentCommand();
    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<CommandStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Y lệnh",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(builder: (context) {
          if (store.isLoading) {
            return const AppCircleLoading();
          }
          return ListView(
            children: [
              _listItem("Thời gian: ", store.commandData?.createDatetime ?? ""),
              _listItem("Bác sĩ: ", store.commandData?.nameDoctor ?? ""),
              _listItem("Diễn biến: ", store.commandData?.progression ?? ""),
              _listItem("Chế độ chăm sóc: ", store.commandData?.careMode ?? ""),
              _listItem(
                  "Cấp độ chăm sóc: ", store.commandData?.careLevel ?? ""),
              _listItem("Chỉ định thuốc: ", store.commandData?.medicines ?? ""),
              _listItem("Chỉ định DVKT: ", store.commandData?.service ?? ""),
              _listItem(
                  "Chế độ dinh dưỡng: ", store.commandData?.nutrition ?? "")
            ],
          );
        }),
      ),
    );
  }

  Widget _listItem(String title, Object description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.heading4.copyWith(color: AppColors.black),
          ),
          const SizedBox(
            width: 8,
          ),
          if (description is String)
            Text(
              description,
            ),
          (description is List<Medicines> && description.isNotEmpty)
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) {
                    final medicines = description[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("- Số lượng: ${medicines.medNumber}"),
                        Text("- Dạng: ${medicines.medUnit}"),
                        Text("- Loại: ${medicines.medText}"),
                        Text("- Chỉ định: ${medicines.medUse}"),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider(
                      color: AppColors.grayLight,
                    );
                  },
                  itemCount: 2)
              : SizedBox(),
          if (description is List<Service>)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(description.length,
                  (index) => Text("- ${description[index].sevText}")),
            )
        ],
      ),
    );
  }
}

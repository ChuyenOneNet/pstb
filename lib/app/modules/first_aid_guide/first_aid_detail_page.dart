import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency/emergency_store.dart';
import 'package:pstb/app/models/emergency_model.dart';
import 'package:pstb/utils/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../utils/l10n.dart';
import '../../../utils/styles.dart';
import '../../../widgets/stateless/app_bar.dart';

class FirstAidDetailPage extends StatelessWidget {
  final EmergencyModel data;

  const FirstAidDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            l10n(context).emergency_call.toUpperCase(),
            style: Styles.titleButton,
          ),
          onPressed: () async {
            final controller = Modular.get<EmergencyStore>();
            await launchUrlString('tel://${controller.sosPhoneNumber}');
          },
          icon: const Icon(Icons.call),
          backgroundColor: AppColors.error500,
        ),
        appBar: CustomAppBar(
          title: data.title ?? "",
          isBack: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Html(
                data: data.description ?? '',
                style: {
                  "body": Style(
                    fontFamily: 'Inter',
                    fontSize: FontSize(14.0),
                    color: AppColors.black,
                  ),
                },
              ),
            ),
          ),
        ));
  }
}

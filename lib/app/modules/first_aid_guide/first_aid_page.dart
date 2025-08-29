import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency/emergency_store.dart';
import 'package:pstb/app/modules/first_aid_guide/first_aid_detail_page.dart';
import 'package:pstb/app/modules/first_aid_guide/first_aid_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FirstAidPage extends StatefulWidget {
  final String title;

  const FirstAidPage({this.title = "FirstAidPage", Key? key}) : super(key: key);

  @override
  _FirstAidPageState createState() => _FirstAidPageState();
}

class _FirstAidPageState extends ModularState<FirstAidPage, FirstAidStore> {
  @override
  void initState() {
    controller.getEmergency(newContext: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n(context).tutorial_title,
      ),
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Observer(
        builder: (context) {
          if (controller.loading) {
            return const Center(
              child: AppCircleLoading(),
            );
          }
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(16.0),
            children: List.generate(
              controller.listTutorial.length,
              (index) => GestureDetector(
                onTap: () {
                  var item = controller.getFirstAid(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstAidDetailPage(data: item)),
                  );
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                      border: Border.all(
                        color: AppColors.lightSilver,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(
                          controller.listTutorial[index].img ?? '',
                          fit: BoxFit.fitHeight,
                          errorBuilder: (_, __, ___) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        child: Text(
                          controller.listTutorial[index].title ?? '',
                          style: Styles.content,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

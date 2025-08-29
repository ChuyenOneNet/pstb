import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/emergency/emergency_store.dart';
import 'package:pstb/app/modules/emergency/widgets/fact_widget.dart';

import '../../../widgets/stateless/app_bar.dart';

class EmergencyPage extends StatefulWidget {
  final String title;
  const EmergencyPage({this.title = "EmergencyPage",Key?key}) : super(key: key);

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends ModularState<EmergencyPage, EmergencyStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FactWidget(
        controller: controller,
      ),
    );
  }
}

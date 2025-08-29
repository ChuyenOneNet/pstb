import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/modules/profile/pages/steps_foot/steps_foot_store.dart';
import 'package:pstb/app/modules/profile/pages/steps_foot/widget/circle_step_count_widget.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';

class StepsFootPage extends StatefulWidget {
  const StepsFootPage({Key? key}) : super(key: key);

  @override
  State<StepsFootPage> createState() => _StepsFootPageState();
}

class _StepsFootPageState extends State<StepsFootPage> {
  final stepsFootStore = Modular.get<StepsFootStore>();

  // khởi tạo stream
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    requestPermission(context);
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    stepsFootStore.steps = event.steps.toString();
    // setState(() {
    //   _steps = event.steps.toString();
    // });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    stepsFootStore.steps = '0';
    // setState(() {
    //   _steps = '0';
    // });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Đo bước chân",
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Số bước chân hôm nay",
                style: Styles.titleItem,
              ),
              CircleStepCountWidget(
                step: stepsFootStore.steps,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> requestPermission(BuildContext context) async {
    final status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      // Quyền đã được cấp, tiến hành xử lý tại đây
      print('Permission granted');
    } else if (status.isDenied) {
      // Quyền bị từ chối, hiển thị dialog yêu cầu cấp quyền
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
              'Please grant permission to access activity recognition.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Huỷ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Mở cài đặt'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        ),
      );
    }
  }
}

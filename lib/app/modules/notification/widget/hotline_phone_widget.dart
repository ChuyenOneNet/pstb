import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pstb/app/app_store.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/widgets/stateful/stateful_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HotlinePhoneWidget extends StatelessWidget {
  final AppStore _appstore = Modular.get<AppStore>();

  HotlinePhoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () async {
        await launchUrlString('tel://${_appstore.supportLinePhoneNumber}');
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 42, top: 16),
            decoration: BoxDecoration(color: AppColors.background, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Text(_appstore.supportLinePhoneNumber,
                  style: Styles.subtitleSmallest
                      .copyWith(color: AppColors.primary)),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.only(left: 6, top: 6, bottom: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white.withOpacity(0.8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: const Offset(-3, 5),
                  ),
                ]),
            child: Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(22)),
                  child: const Center(
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 25,
                  child: CustomPaint(
                    painter: TrianglePainter(
                      strokeColor: AppColors.primary,
                      strokeWidth: 10,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    child: const SizedBox(
                      height: 10,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(x / 10, 0)
      ..lineTo(x, y + 5)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

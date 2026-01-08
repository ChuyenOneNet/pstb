import 'package:url_launcher/url_launcher_string.dart';

Future<void> callHotline() async {
  const phone = 'tel:19001932';

  if (await canLaunchUrlString(phone)) {
    await launchUrlString(
      phone,
      mode: LaunchMode.externalApplication, // quan trọng
    );
  } else {
    throw 'Không thể gọi $phone';
  }
}

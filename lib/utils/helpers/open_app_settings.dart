// utils/open_app_settings.dart
import 'package:url_launcher/url_launcher.dart';

Future<void> openAppSettings() async {
  final uri = Uri.parse('app-settings:');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

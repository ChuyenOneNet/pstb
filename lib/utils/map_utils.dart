import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    final Uri url = Uri.parse(googleUrl);
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}

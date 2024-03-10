import 'package:url_launcher/url_launcher.dart';

class LaunchUrlUseCase {
  Future<void> launchInBrowser(String urlString) async {
    Uri uri = Uri.parse(urlString);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $uri');
    }
  }
}

import 'package:url_launcher/url_launcher.dart';

const String TERMS_OF_USE = "https://totalfit.app/terms-of-use";
const String PRIVACY_POLICY = "https://totalfit.app/privacy-policy";

launchURL(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print(e.toString());
  }
}

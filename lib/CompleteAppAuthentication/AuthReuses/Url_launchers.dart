import 'package:url_launcher/url_launcher.dart';

class launches {
  static launchJr() async {
    String _jrurl = "https://www.jrcompliance.com/";
    if (!await launch(_jrurl)) throw 'Could not launch $_jrurl';
  }

  static termsofuse() async {
    String _jrurl = "https://www.jrcompliance.com/terms-and-conditions";
    if (!await launch(_jrurl)) throw 'Could not launch $_jrurl';
  }

  static privacy() async {
    String _jrurl = "https://www.jrcompliance.com/privacy-policy";
    if (!await launch(_jrurl)) throw 'Could not launch $_jrurl';
  }

  static purchase() async {
    String _jrurl = "https://www.jrcompliance.com/purchase-and-billing";
    if (!await launch(_jrurl)) throw 'Could not launch $_jrurl';
  }
}

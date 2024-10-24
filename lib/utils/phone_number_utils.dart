import 'package:url_launcher/url_launcher_string.dart';

class PhoneNumberUtils {
  static void callPhoneNumber(String phoneNumber) {
    launchUrlString('tel:1$phoneNumber');
  }

  static void callEmergencyServices() {
    launchUrlString('tel:911');
  }
}
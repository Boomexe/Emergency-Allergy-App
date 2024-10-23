import 'package:url_launcher/url_launcher_string.dart';

class PhoneNumberUtils {
  static void callPhoneNumber(String phoneNumber) {
    launchUrlString('tel:1$phoneNumber');
    // launchUrlString('tel:+1\-${phoneNumber.substring(0, 3)}\-${phoneNumber.substring(3, 6)}\-${phoneNumber.substring(6, 10)}');
  }
}
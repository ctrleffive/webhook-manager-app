import 'package:webhook_manager/src/constants/enums.dart';

class Helpers {
  static RequestMethod methodFormater(String input) {
    return RequestMethod.values.firstWhere(
      (RequestMethod method) {
        return method.toString().contains(input.toLowerCase());
      },
      orElse: () => null,
    );
  }

  static String methodFormaterReverse(RequestMethod input) {
    return input.toString().replaceAll('RequestMethod.', '').toUpperCase();
  }

  static String eventFormater(String input) {
    return input.toLowerCase().replaceAll(' ', '_');
  }
}

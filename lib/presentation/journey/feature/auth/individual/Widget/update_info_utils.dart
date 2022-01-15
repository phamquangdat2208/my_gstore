import 'package:intl/intl.dart';

class UpdateInfoUtils {
  /// 20/11/2021 => 2021-11-20T00:00:00
  static String convertDateTimeDisplayToDateTimeData(String? input) {
    try {
      if (input?.isEmpty ?? true) {
        return '';
      }
      DateFormat dateFormatInput = DateFormat('dd/MM/yyyy');
      DateFormat dateFormatOutput = DateFormat('yyyy-MM-ddThh:mm:ss');
      return dateFormatOutput.format(dateFormatInput.parse(input!));
    } catch (e) {
      return input ?? '';
    }
  }

  /// DateTime => 20/11/2021
  static String convertDateTimeToDisplay(DateTime? input) {
    if (input == null) {
      return '';
    }
    DateFormat dateFormatInput = DateFormat('dd/MM/yyyy');
    return dateFormatInput.format(input);
  }

  // 2021-11-20T00:00:00 => 20/11/2021
  static String convertDateDataToDateDisplay(String? input) {
    try {
      if (input?.isEmpty ?? true) {
        return '';
      }
      DateFormat dateFormatInput = DateFormat('yyyy-MM-ddThh:mm:ss');
      DateFormat dateFormatOutput = DateFormat('dd/MM/yyyy');
      return dateFormatOutput.format(dateFormatInput.parse(input!));
    } catch (e) {
      return input ?? '';
    }
  }
}

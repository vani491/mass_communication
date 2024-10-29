// util.dart
// Utility class to include various helper methods
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../reusable_widget/loading_indicator.dart';

class Util {
  // Utility method to format a date
  static String formatDate(DateTime date) {
    return "\${date.year}-\${date.month.toString().padLeft(2, '0')}-\${date.day.toString().padLeft(2, '0')}";
  }

  // Utility method to generate a unique random number using date and time
  static int generateUniqueNumber() {
    final now = DateTime.now();
    final random = now.millisecondsSinceEpoch % 1000000; // Generate a unique number using milliseconds
    return random;
  }


  // Method to show loading indicator
  static void showLoadingIndicator(BuildContext context, String loadingMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return  Dialog(
          backgroundColor: Colors.transparent,
          child: LoadingIndicator(message: loadingMessage),
        );
      },
    );
  }

  // Convert TimeOfDay to String in "HH:mm" format
  static String timeOfDayToString(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
  // Convert String in "HH:mm" format to TimeOfDay
  static TimeOfDay stringToTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }


}

// util.dart
// Utility class to include various helper methods
import 'package:flutter/material.dart';

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

}

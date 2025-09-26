import 'package:flutter/material.dart';

class ResponsiveHelper {
  static int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      // Phone
      return 1;
    } else if (screenWidth < 900) {
      // Fold phone / small tablet
      return 2;
    } else {
      // Tablet / large screen
      return 3;
    }
  }
}

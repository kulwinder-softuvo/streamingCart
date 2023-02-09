import 'package:flutter/material.dart';

extension StringExtensions on String? {
  String toStringConversion() {
    if (this == null || this == "null") return "";
    return toString();
  }

  bool isNullOrEmpty() {
    if (this != null && this != "null" && this != "") return true;
    return false;
  }

  double toDoubleConversion() {
    if (this == null || this == "null" || this == "" || this == " ") return 0.0;
    if (isNumericOnly()) return double.parse(this!);
    return 0.0;
  }

  int toIntConversionWithDefaultValueOne() {
    if (this == null || this == "null" || this == "" || this == " ") return 1;
    if (isNumericOnly()) return double.parse(this!).toInt();
    return 1;
  }

  int toIntConversion() {
    if (this == null || this == "null" || this == "" || this == " ") return 0;
    if (isNumericOnly()) return double.parse(this!).toInt();
    return 0;
  }

  bool isNumericOnly() {
    if (this == null) {
      return false;
    }
    return this!.contains(RegExp(r'[0-9]'));
  }

/*  bool isValidPanCard() {
    if (this == null) return false;
    final regExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}+$');
    return regExp.hasMatch(this!);
  }*/

  // For replacing
  String replaceType(String value) {
    return this?.replaceAll("name", value) ?? "";
  }
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}

extension ColorConversion on Color {
  MaterialColor toMaterialColor() {
    final List strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final r = red, g = green, b = blue;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(value, swatch);
  }
}

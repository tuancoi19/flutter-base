import 'package:flutter_base/configs/app_configs.dart';
import 'package:intl/intl.dart';

import 'logger.dart';

class AppDateUtils {
  AppDateUtils._();

  static DateTime? fromString(String date, {String? format}) {
    if ((format ?? "").isNotEmpty) {
      try {
        return DateFormat(format).parse(date);
      } catch (e, s) {
        logger.e(e, stackTrace: s);
      }
    }
    try {
      return DateTime.parse(date);
    } catch (e, s) {
      logger.e(e, stackTrace: s);
    }
    //
    try {
      return DateFormat("yyyy/MM/dd").parse(date);
    } catch (e, s) {
      logger.e(e, stackTrace: s);
    }
    return null;
  }

  static String toDateString(DateTime dateTime,
      {String format = AppConfigs.dateDisplayFormat}) {
    try {
      return DateFormat(format).format(dateTime.toLocal());
    } catch (e) {
      return '';
    }
  }

  static String toDateTimeString(DateTime dateTime,
      {String format = AppConfigs.dateTimeDisplayFormat}) {
    try {
      return DateFormat(format).format(dateTime.toLocal());
    } catch (e) {
      return '';
    }
  }

  static String toDateAPIString(DateTime dateTime,
      {String format = AppConfigs.dateAPIFormat}) {
    try {
      return DateFormat(format).format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String toDateTimeAPIString(DateTime dateTime,
      {String format = AppConfigs.dateTimeAPIFormat}) {
    try {
      return dateTime.toIso8601String();
    } catch (e) {
      return '';
    }
  }

  static DateTime startOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0);
  }

  static DateTime endOfDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
  }
}

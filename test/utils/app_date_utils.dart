import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Test AppDateUtils', () {
    late DateTime dateTime;
    late String dateTimeStr;
    late String dateTimeFormat;

    setUp(() {
      dateTime = DateTime(2001, 02, 03, 04, 05, 06);
      dateTimeStr = DateFormat(AppConfigs.dateTimeAPIFormat).format(dateTime);
      dateTimeFormat = AppConfigs.dateTimeAPIFormat;
    });

    test('fromString', () {
      expect(AppDateUtils.fromString(dateTimeStr, format: dateTimeFormat),
          dateTime);
      expect(AppDateUtils.fromString("dateTimeStr", format: dateTimeFormat),
          null);
      expect(AppDateUtils.toDateString(dateTime, format: dateTimeFormat),
          dateTimeStr);
      expect(AppDateUtils.toDateString(dateTime, format: dateTimeFormat),
          dateTimeStr);
      expect(AppDateUtils.fromString(dateTimeStr, format: dateTimeFormat),
          dateTime);
      expect(AppDateUtils.toDateAPIString(dateTime, format: dateTimeFormat),
          dateTimeStr);
      expect(AppDateUtils.toDateTimeAPIString(dateTime, format: dateTimeFormat),
          dateTime.toIso8601String());
      expect(
          AppDateUtils.startOfDay(dateTime), DateTime(2001, 02, 03, 0, 0, 0));
      expect(
          AppDateUtils.endOfDay(dateTime), DateTime(2001, 02, 03, 23, 59, 59));
    });
  });
}

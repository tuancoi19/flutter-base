import 'package:flutter/material.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Utils', () {
    String validEmail = "mobile@newwave.vn";
    String invalidEmail = "mobile_newwave.vn";
    String validPhone1 = "+84989123456";
    String validPhone2 = "0989123456";
    String invalidPhone1 = "a989123456";
    String validUrl1 = "https://google.com";
    String validUrl2 = "http://google.com";
    String invalidUrl1 = "http//google.com";
    String redColorHex = "ff000000";
    Color redColor = Colors.black.withOpacity(1.0);

    setUp(() {});

    test('fromString', () {
      expect(Utils.isEmail(validEmail), true);
      expect(Utils.isEmail(invalidEmail), false);
      expect(Utils.isPhoneNumber(validPhone1), true);
      expect(Utils.isPhoneNumber(validPhone2), true);
      expect(Utils.isPhoneNumber(invalidPhone1), false);
      expect(Utils.isURL(validUrl1), true);
      expect(Utils.isURL(validUrl2), true);
      expect(Utils.isURL(invalidUrl1), false);
      expect(Utils.getColorFromHex(redColorHex), redColor);
      expect(Utils.getHexFromColor(redColor), redColorHex);
    });
  });
}

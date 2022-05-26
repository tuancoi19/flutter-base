import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppState', () {
    test('returns correct values for initial AppState', () {
      const state = AppState();
      expect(state.user, null);
      expect(state.fetchProfileStatus, LoadStatus.initial);
      expect(state.signOutStatus, LoadStatus.initial);
    });
  });
}

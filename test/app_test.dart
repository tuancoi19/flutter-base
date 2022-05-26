import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_base/app.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('MovieApp', () {
    testWidgets('renders MovieApp', (tester) async {
      await tester.pumpWidget(
        const MyApp(),
      );
      expect(find.byType(GetMaterialApp), findsOneWidget);
    });
  });
}

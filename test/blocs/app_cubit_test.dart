import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AppCubit', () {
    test('initial state is correct', () {
      expect(
          AppCubit(
                  userRepo: MockUserRepository(),
                  authRepo: MockAuthRepository())
              .state,
          const AppState());
    });

    group('test appCubit', () {
      late AppCubit appCubit;
      late UserRepository userRepository;
      late AuthRepository authRepository;

      setUp(() async {
        userRepository = MockUserRepository();
        authRepository = MockAuthRepository();

        when(() async => userRepository.getProfile())
            .thenAnswer((_) async => Future.value(UserEntity()));

        when(() async => authRepository.removeToken())
            .thenAnswer((_) async => Future.value());

        appCubit = AppCubit(
          userRepo: userRepository,
          authRepo: authRepository,
        );
      });

      blocTest<AppCubit, AppState>(
        'emits fetchProfile',
        build: () => appCubit,
        act: (cubit) => cubit.fetchProfile(),
        expect: () => [
          const AppState(fetchProfileStatus: LoadStatus.loading),
          AppState(user: UserEntity(), fetchProfileStatus: LoadStatus.success),
        ],
      );

      blocTest<AppCubit, AppState>(
        'emits updateProfile',
        build: () => appCubit,
        act: (cubit) => cubit.updateProfile(UserEntity(username: 'new user')),
        expect: () => [
          AppState(user: UserEntity(username: 'new user')),
        ],
      );

      blocTest<AppCubit, AppState>(
        'emits signOut',
        build: () => appCubit,
        act: (cubit) => cubit.signOut(),
        expect: () => [
          const AppState(signOutStatus: LoadStatus.loading),
          const AppState(signOutStatus: LoadStatus.success),
        ],
      );
    });
  });
}

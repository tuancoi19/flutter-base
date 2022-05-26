import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/enums/load_status.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(const AppState());

  void fetchProfile() async {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
    try {
      final user = await userRepo.getProfile();
      emit(state.copyWith(
        user: user,
        fetchProfileStatus: LoadStatus.success,
      ));
    } catch (e, s) {
      emit(state.copyWith(fetchProfileStatus: LoadStatus.failure));
      logger.e(e, stackTrace: s);
    }
  }

  void updateProfile(UserEntity? user) {
    emit(state.copyWith(user: user));
  }

  ///Sign Out
  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await authRepo.removeToken();
      emit(state.removeUser().copyWith(
            signOutStatus: LoadStatus.success,
          ));
    } catch (e, s) {
      logger.e(e, stackTrace: s);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }
}

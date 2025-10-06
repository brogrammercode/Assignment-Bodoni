import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedplan/core/config/exception.dart';
import 'package:wedplan/features/auth/data/dto.dart';
import 'package:wedplan/features/auth/data/service.dart';

import '../../data/model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final service = AuthService();

  AuthCubit() : super(AuthState()) {
    init();
  }

  void init() async {
    emit(state.copyWith(getUserStatus: AppStatus.loading));
    try {
      final id = await service.repo.getId();
      if (id != null) {
        try {
          final user = await service.getUserById(id: id);
          log("USER: ${user.id}, ${user.email}, ${user.password}");
          emit(
            state.copyWith(
              user: user,
              getUserStatus: AppStatus.success,
              error: null,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              getUserStatus: AppStatus.failed,
              error: e.toString(),
            ),
          );
        }
      }
      emit(state.copyWith(getUserStatus: AppStatus.success));
    } catch (e) {
      emit(state.copyWith(getUserStatus: AppStatus.failed));
    }
  }

  Future<bool> login({required LoginDTO loginDto}) async {
    emit(state.copyWith(loginStatus: AppStatus.loading));
    try {
      final user = await service.login(loginDto: loginDto);
      log("USER: ${user.id}");
      emit(
        state.copyWith(user: user, loginStatus: AppStatus.success, error: null),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(error: e.toString(), loginStatus: AppStatus.failed));
      return false;
    }
  }

  Future<bool> register({required LoginDTO loginDto}) async {
    emit(state.copyWith(registerStatus: AppStatus.loading));
    try {
      final user = await service.register(loginDto: loginDto);
      log("USER: ${user.id}");
      emit(
        state.copyWith(
          user: user,
          registerStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(
        state.copyWith(error: e.toString(), registerStatus: AppStatus.failed),
      );
      return false;
    }
  }
}

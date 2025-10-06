part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final User? user;
  final AppStatus loginStatus;
  final AppStatus registerStatus;
  final AppStatus getUserStatus;
  final String? error;

  const AuthState({
    this.user,
    this.loginStatus = AppStatus.initial,
    this.registerStatus = AppStatus.initial,
    this.getUserStatus = AppStatus.initial,
    this.error,
  });

  AuthState copyWith({
    User? user,
    AppStatus? loginStatus,
    AppStatus? registerStatus,
    AppStatus? getUserStatus,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      getUserStatus: getUserStatus ?? this.getUserStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    user,
    loginStatus,
    registerStatus,
    getUserStatus,
    error,
  ];
}

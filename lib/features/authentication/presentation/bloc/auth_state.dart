part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);
}

final class AuthUnauthenticated extends AuthState {
  final String? message;

  const AuthUnauthenticated([this.message]);
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);
}

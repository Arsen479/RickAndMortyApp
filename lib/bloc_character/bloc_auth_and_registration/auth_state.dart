part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucces extends AuthState {
  final String? message;

  AuthSucces(this.message);
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

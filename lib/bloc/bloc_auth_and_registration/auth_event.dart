part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin(this.email, this.password);
}

final class Registration extends AuthEvent {
  final String email;
  final String password;

  Registration(this.email, this.password);
}

final class checkUserAccsec extends AuthEvent {}

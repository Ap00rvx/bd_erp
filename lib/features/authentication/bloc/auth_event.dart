part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent(this.username, this.password);
}
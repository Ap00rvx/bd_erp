part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final UserModel data;
  AuthSuccess(this.data); 
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
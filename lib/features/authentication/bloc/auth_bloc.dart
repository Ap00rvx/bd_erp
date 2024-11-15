import 'dart:convert';

import 'package:bd_erp/features/authentication/repository/auth_rpository.dart';
import 'package:bd_erp/locator.dart';
import 'package:bd_erp/models/login_data_model.dart';
import 'package:bd_erp/models/user_model.dart';
import 'package:bd_erp/static/network/urls.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final res = await locator
            .get<AuthRepository>()
            .login(event.username, event.password);

        await res.fold((data) async {
          print(data.toJson());

          final user = await locator.get<AuthRepository>().getUser(data);

          if (!emit.isDone) {
            emit(AuthSuccess(user));
          }
        }, (err) async {
          if (!emit.isDone) {
            emit(AuthFailure(err));
          }
        });
      } catch (e) {
        if (!emit.isDone) {
          emit(AuthFailure(e.toString()));
        }
      }
    });
  }
}

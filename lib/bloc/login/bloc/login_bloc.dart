import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:task_2/repos/auth_repo/auth_repo.dart';
import 'package:task_2/utils/utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepo) : super(const LoginState()) {
    on<EmailChangedInLoginEvent>(_emailChangedEvent);
    on<PasswordChangedInLoginEvent>(_passwordChangedEvent);
    on<LoginButtonEvent>(_loginButtonEvent);
  }

  final AuthRepo _authRepo;

  FutureOr<void> _emailChangedEvent(
      EmailChangedInLoginEvent event, Emitter<LoginState> emit) {
    final newEmail = event.email;
    emit(state.copyWith(email: newEmail));
  }

  FutureOr<void> _passwordChangedEvent(
      PasswordChangedInLoginEvent event, Emitter<LoginState> emit) {
    final newPassword = event.password;
    emit(state.copyWith(password: newPassword));
  }

  FutureOr<void> _loginButtonEvent(
      LoginButtonEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    try {
      final bool authnticated =
          await _authRepo.loginUser(state.email, state.password);
      if (authnticated) {
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } else {
        emit(state.copyWith(loginStatus: LoginStatus.error));
        Utils.flutterToast("Some Error Ocuured");
      }
    } catch (e) {
      emit(
          state.copyWith(loginStatus: LoginStatus.error, errMsg: e.toString()));
      Utils.flutterToast(e.toString());
    }
  }
}

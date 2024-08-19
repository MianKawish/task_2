import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_2/repos/auth_repo/auth_repo.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(this._authRepo) : super(const SplashState()) {
    on<LoginStatusEvent>(_loginStatusEvent);
  }
  final AuthRepo _authRepo;

  FutureOr<void> _loginStatusEvent(
      LoginStatusEvent event, Emitter<SplashState> emit) async {
    bool status = _authRepo.isUserLoggedIn();

    emit(state.copyWith(isLoggedIn: status));
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_2/repos/auth_repo/auth_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(this._authRepo) : super(const SignupState()) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<FormSubmitEvent>(_formSubmitEvent);
    on<FirstNameChangedEvent>(_firstNameChangedEvent);
    on<LastNameChangedEvent>(_lastNameChangedEvent);
  }

  final AuthRepo _authRepo;

  FutureOr<void> _emailChangedEvent(
      EmailChangedEvent event, Emitter<SignupState> emit) {
    final newEmailValue = event.email;
    emit(state.copyWith(email: newEmailValue));
  }

  FutureOr<void> _passwordChangedEvent(
      PasswordChangedEvent event, Emitter<SignupState> emit) {
    final newpwdValue = event.password;
    emit(state.copyWith(password: newpwdValue));
  }

  FutureOr<void> _firstNameChangedEvent(
      FirstNameChangedEvent event, Emitter<SignupState> emit) {
    final newFirstNameValue = event.firstName;
    emit(state.copyWith(firstName: newFirstNameValue));
  }

  FutureOr<void> _lastNameChangedEvent(
      LastNameChangedEvent event, Emitter<SignupState> emit) {
    final newLastNameValue = event.lastName;

    emit(state.copyWith(lastName: newLastNameValue));
  }

  FutureOr<void> _formSubmitEvent(
      FormSubmitEvent event, Emitter<SignupState> emit) async {
    try {
      emit(state.copyWith(status: FormStatus.loading));

      final user = await _authRepo.registerUser(
          state.email, state.password, state.firstName, state.lastName);

      if (user != null) {
        emit(state.copyWith(status: FormStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errMsg: e.toString()));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_2/bloc/signup/bloc/signup_bloc.dart';
import 'package:task_2/repos/auth_repo/auth_repo.dart';
import 'package:task_2/utils/utils.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._authRepo) : super(const HomeState()) {
    on<FieldChangerEvent>(_fieldEnablerEvent);
    on<LogoutUserEvent>(_logoutUserEvent);
    on<UpdateUserDataEvent>(_updateUserDataEvent);
    on<FirstNameChangedInHomeEvent>(_firstNameChangedEvent);
    on<LastNameChangedInHomeEvent>(_lastNameChangedEvent);
    on<InsertDataToFieldsEvent>(_insertDataToFieldsEvent);
  }
  final AuthRepo _authRepo;

  FutureOr<void> _fieldEnablerEvent(
      FieldChangerEvent event, Emitter<HomeState> emit) {
    print("Before Emitting State Value ${state.isEnabled}");

    bool newEnabledValue = !state.isEnabled;

    emit(state.copyWith(isEnabled: newEnabledValue));
    print("After Emitting: The emitted value is $newEnabledValue");
  }

  FutureOr<void> _logoutUserEvent(
      LogoutUserEvent event, Emitter<HomeState> emit) async {
    try {
      await _authRepo.logoutUser();
      emit(state.copyWith(status: FormStatus.userLogout));
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error));
    }
  }

  FutureOr<void> _updateUserDataEvent(
      UpdateUserDataEvent event, Emitter<HomeState> emit) {
    _authRepo.updateUserData(state.firstName, state.lastName);
    Utils.flutterToast("Data updated successfully");

    emit(state.copyWith(isEnabled: !state.isEnabled));
  }

  FutureOr<void> _firstNameChangedEvent(
      FirstNameChangedInHomeEvent event, Emitter<HomeState> emit) {
    final newFirstName = event.firstName;
    emit(state.copyWith(firstName: newFirstName));
  }

  FutureOr<void> _lastNameChangedEvent(
      LastNameChangedInHomeEvent event, Emitter<HomeState> emit) {
    final newLastName = event.lastName;
    emit(state.copyWith(lastName: newLastName));
  }

  FutureOr<void> _insertDataToFieldsEvent(
      InsertDataToFieldsEvent event, Emitter<HomeState> emit) async {
    try {
      List<String> userList = await _authRepo.getUserData();

      print(userList);
      emit(state.copyWith(
          email: userList[2], firstName: userList[0], lastName: userList[1]));
    } catch (e) {
      print(e.toString());
    }
  }
}

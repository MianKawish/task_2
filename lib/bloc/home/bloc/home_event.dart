part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FieldChangerEvent extends HomeEvent {}

class LogoutUserEvent extends HomeEvent {}

class UpdateUserDataEvent extends HomeEvent {}

class FirstNameChangedInHomeEvent extends HomeEvent {
  final String firstName;
  const FirstNameChangedInHomeEvent(this.firstName);
  @override
  List<Object> get props => [firstName];
}

class LastNameChangedInHomeEvent extends HomeEvent {
  final String lastName;
  const LastNameChangedInHomeEvent(this.lastName);
  @override
  List<Object> get props => [lastName];
}

class InsertDataToFieldsEvent extends HomeEvent {}

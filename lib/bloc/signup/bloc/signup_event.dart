part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends SignupEvent {
  final String email;
  const EmailChangedEvent(this.email);
  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends SignupEvent {
  final String password;
  const PasswordChangedEvent(this.password);
  @override
  List<Object> get props => [password];
}

class FirstNameChangedEvent extends SignupEvent {
  final String firstName;
  const FirstNameChangedEvent(this.firstName);
  @override
  List<Object> get props => [firstName];
}

class LastNameChangedEvent extends SignupEvent {
  final String lastName;
  const LastNameChangedEvent(this.lastName);
  @override
  List<Object> get props => [lastName];
}

class FormSubmitEvent extends SignupEvent {}

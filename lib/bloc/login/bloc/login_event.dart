part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedInLoginEvent extends LoginEvent {
  final String email;
  const EmailChangedInLoginEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChangedInLoginEvent extends LoginEvent {
  final String password;
  const PasswordChangedInLoginEvent(this.password);

  @override
  List<Object> get props => [password];
}

class LoginButtonEvent extends LoginEvent {}

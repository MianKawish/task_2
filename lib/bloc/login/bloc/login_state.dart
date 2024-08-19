part of 'login_bloc.dart';

enum LoginStatus { intial, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus loginStatus;
  final String? errMsg;
  const LoginState(
      {this.email = '',
      this.password = "",
      this.loginStatus = LoginStatus.intial,
      this.errMsg});
  LoginState copyWith(
      {String? email,
      String? password,
      LoginStatus? loginStatus,
      String? errMsg}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        loginStatus: loginStatus ?? this.loginStatus,
        errMsg: errMsg ?? this.errMsg);
  }

  @override
  List<Object> get props => [email, password, loginStatus];
}

final class LoginInitial extends LoginState {}

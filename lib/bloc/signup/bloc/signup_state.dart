part of 'signup_bloc.dart';

enum FormStatus { intial, loading, success, error, userLogout }

class SignupState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final FormStatus status;
  final String? errMsg;
  const SignupState(
      {this.lastName = '',
      this.firstName = '',
      this.email = '',
      this.password = '',
      this.status = FormStatus.intial,
      this.errMsg});
  SignupState copyWith(
      {String? email,
      String? password,
      FormStatus? status,
      String? errMsg,
      String? firstName,
      String? lastName}) {
    return SignupState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errMsg: errMsg ?? this.errMsg);
  }

  @override
  List<Object> get props => [firstName, lastName, email, password, status];
}

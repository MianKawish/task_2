part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final FormStatus status;
  final bool isEnabled;

  const HomeState(
      {this.firstName = '',
      this.lastName = '',
      this.email = '',
      this.status = FormStatus.intial,
      this.isEnabled = false});

  HomeState copyWith(
      {String? firstName,
      String? lastName,
      FormStatus? status,
      String? email,
      bool? isEnabled}) {
    return HomeState(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        status: status ?? this.status,
        isEnabled: isEnabled ?? this.isEnabled);
  }

  @override
  List<Object> get props => [firstName, lastName, email, status, isEnabled];
}

part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UserAuthEventLogin extends AuthEvent {
  const UserAuthEventLogin({required this.context});

  final BuildContext context;
}

class UserAuthEventLogout extends AuthEvent {}

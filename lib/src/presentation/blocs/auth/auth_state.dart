part of 'auth_bloc.dart';

// class AuthState extends Equatable {
//   const AuthState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class AuthInitial extends AuthState {}
class UserAuthState {
  UserAuthState();
}

class UserAuthInitial extends UserAuthState {}

class UserAuthLoading extends UserAuthState {}

class UserAuthAuthenticated extends UserAuthState {
  final String code;
  final String state;
  final String liffClientId;
  final Uri liffRedirectUri;
  final String accessToken;

  UserAuthAuthenticated({
    required this.code,
    required this.state,
    required this.liffClientId,
    required this.liffRedirectUri,
    required this.accessToken,
  });
}

class UserAuthLogout extends UserAuthState {}

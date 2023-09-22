part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  const AuthState({this.authStatus = AuthStatus.initial});

  final AuthStatus authStatus;

  @override
  List<Object> get props => [authStatus];

  AuthState copyWith({AuthStatus? authStatus}) {
    return AuthState(authStatus: authStatus ?? this.authStatus);
  }
}

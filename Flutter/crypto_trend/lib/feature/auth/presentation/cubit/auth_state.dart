abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthCredentialsLoaded extends AuthState {
  final String email;
  final String password;
  AuthCredentialsLoaded(this.email, this.password);
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/repository/AppRepository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppRepository repository;

  AuthCubit({required this.repository}) : super(AuthInitial());

  void loadSavedCredentials() async {
    final creds = await repository.getSecureCredentials();
    if (creds['email'] != null && creds['password'] != null) {
      emit(AuthCredentialsLoaded(creds['email']!, creds['password']!));
    }
  }

  Future<void> login(String email, String password, bool rememberMe) async {
    emit(AuthLoading());
    try {
      final user = await repository.login(email, password);
      if (user != null) {
        await repository.saveUserSession(user['id'], user['username']);
        if (rememberMe) {
          await repository.saveSecureCredentials(email, password);
        } else {
          await repository.clearSecureCredentials();
        }
        emit(AuthSuccess());
      } else {
        emit(AuthError("Invalid credentials"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    if (!email.contains('@')) {
      emit(AuthError('Enter a valid email'));
      return;
    }
    emit(AuthLoading());
    try {
      String username = email.split('@')[0];
      await repository.signUp(email, password, username);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Email already exists'));
    }
  }
}
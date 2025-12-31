import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthStateChecked>(_onAuthStateChecked);

    // Listen to auth state changes
    authRepository.authStateChanges.listen((userId) {
      if (userId != null) {
        add(AuthStateChecked(userId: userId));
      } else {
        add(AuthStateChecked(userId: null));
      }
    });
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userId = await authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (userId != null) {
        emit(AuthAuthenticated(userId: userId));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userId = await authRepository.signUpWithEmailAndPassword(
        event.email,
        event.password,
      );
      if (userId != null) {
        emit(AuthAuthenticated(userId: userId));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onAuthStateChecked(
      AuthStateChecked event, Emitter<AuthState> emit) async {
    if (event.userId != null) {
      emit(AuthAuthenticated(userId: event.userId!));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}


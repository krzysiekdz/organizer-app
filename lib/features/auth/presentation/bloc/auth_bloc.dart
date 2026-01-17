import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/sign_out_use_case.dart';
import '../../domain/usecases/get_current_user_id_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AuthRepository
  authRepository; // Still needed for authStateChanges stream

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthStateChecked>(_onAuthStateChecked);

    // Listen to auth state changes
    authRepository.authStateChanges.listen((user) {
      add(AuthStateChecked(user: user));
    });
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signInUseCase(event.email, event.password);

    if (result.failure != null) {
      emit(AuthError(message: result.failure!.message));
    } else if (result.user != null) {
      emit(AuthAuthenticated(user: result.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signUpUseCase(event.email, event.password);

    if (result.failure != null) {
      emit(AuthError(message: result.failure!.message));
    } else if (result.user != null) {
      emit(AuthAuthenticated(user: result.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final failure = await signOutUseCase();

    if (failure != null) {
      emit(AuthError(message: failure.message));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onAuthStateChecked(
    AuthStateChecked event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      emit(AuthAuthenticated(user: event.user!));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}

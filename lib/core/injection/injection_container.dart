import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/services/email_validator_service.dart';
import '../../features/auth/domain/services/password_validator_service.dart';
import '../../features/auth/domain/usecases/sign_in_use_case.dart';
import '../../features/auth/domain/usecases/sign_up_use_case.dart';
import '../../features/auth/domain/usecases/sign_out_use_case.dart';
import '../../features/auth/domain/usecases/get_current_user_id_use_case.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Notes Management
import '../../features/notes_management/data/datasources/folder_remote_datasource.dart';
import '../../features/notes_management/data/datasources/note_remote_datasource.dart';
import '../../features/notes_management/data/repositories/folder_repository_impl.dart';
import '../../features/notes_management/data/repositories/note_repository_impl.dart';
import '../../features/notes_management/domain/repositories/folder_repository.dart';
import '../../features/notes_management/domain/repositories/note_repository.dart';

final sl = GetIt.instance; // Singleton instance of GetIt

Future<void> initializeDependencies() async {
  // Initialize GetStorage
  await GetStorage.init();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Firebase services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Storage
  sl.registerLazySingleton<GetStorage>(() => GetStorage());

  // Auth Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<FirebaseAuth>()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: sl<GetStorage>()),
  );

  // Auth Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  // Auth Domain Services
  sl.registerLazySingleton<EmailValidatorService>(
    () => EmailValidatorServiceImpl(),
  );

  sl.registerLazySingleton<PasswordValidatorService>(
    () => PasswordValidatorServiceImpl(),
  );

  // Auth Use Cases
  sl.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(
      sl<AuthRepository>(),
      emailValidator: sl<EmailValidatorService>(),
      passwordValidator: sl<PasswordValidatorService>(),
    ),
  );

  sl.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(
      sl<AuthRepository>(),
      emailValidator: sl<EmailValidatorService>(),
      passwordValidator: sl<PasswordValidatorService>(),
    ),
  );

  sl.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(sl<AuthRepository>()),
  );

  // Auth BLoC
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUseCase: sl<SignInUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      signOutUseCase: sl<SignOutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
      authRepository: sl<AuthRepository>(),
    ),
  );

  // Notes Management Data Sources
  sl.registerLazySingleton<FolderRemoteDataSource>(
    () => FolderRemoteDataSourceImpl(sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<NoteRemoteDataSource>(
    () => NoteRemoteDataSourceImpl(sl<FirebaseFirestore>()),
  );

  // Notes Management Repositories
  sl.registerLazySingleton<FolderRepository>(
    () => FolderRepositoryImpl(sl<FolderRemoteDataSource>()),
  );

  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(sl<NoteRemoteDataSource>()),
  );

  // Notes Management BLoCs - registered as factories since they need userId
  // These will be created on-demand with userId from AuthBloc
}

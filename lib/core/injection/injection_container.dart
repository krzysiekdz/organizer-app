import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Notes Management
import '../../features/notes_management/data/datasources/folder_remote_datasource.dart';
import '../../features/notes_management/data/datasources/note_remote_datasource.dart';
import '../../features/notes_management/data/repositories/folder_repository_impl.dart';
import '../../features/notes_management/data/repositories/note_repository_impl.dart';
import '../../features/notes_management/domain/repositories/folder_repository.dart';
import '../../features/notes_management/domain/repositories/note_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Firebase services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Auth Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<FirebaseAuth>()),
  );

  // Auth Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // Auth BLoC
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl<AuthRepository>()),
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


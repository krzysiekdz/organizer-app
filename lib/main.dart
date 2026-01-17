import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/features/auth/presentation/pages/login_page.dart'
    show LoginPage;
import 'package:organizer/features/auth/presentation/pages/auth_loading_page.dart'
    show AuthLoadingPage;
import 'package:organizer/features/notes_management/presentation/pages/notes_home_page.dart'
    show NotesHomePage;
import 'core/injection/injection_container.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) =>
            di.sl<AuthBloc>()..add(const AuthStateChecked(user: null)),
        child: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return switch (state) {
          AuthAuthenticated() => const NotesHomePage(),
          AuthUnauthenticated() => LoginPage(authState: state),
          AuthInitial() => LoginPage(authState: state),
          AuthError() => LoginPage(authState: state),
          AuthLoading() => const AuthLoadingPage(),
        };
      },
    );
  }
}

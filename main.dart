import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/logic_folder/visuals/create_account.dart';
import 'package:go_router/go_router.dart';
import 'logic_folder/Bloc_folder/authentaication_bloc/auth_bloc.dart';
import 'logic_folder/Bloc_folder/create_account/create_account_bloc.dart';
import 'logic_folder/Integration_folder_with_backend/user_integration.dart';
import 'logic_folder/Bloc_folder/eye_hide_unhide/eye_bloc.dart';
import 'logic_folder/visuals/SignIn_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Define your GoRouter with routes
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
          create: (context) => PasswordVisibilityBloc(),
          child: SignInScreen(), // Initial route (Sign In)
        ),
      ),
      GoRoute(
        path: '/createAccount',
        builder: (context, state) => CreateAccountScreen(), // Sign Up route
      ),
      // Add more routes here as needed
      GoRoute(
        path: '/error',
        builder: (context, state) =>
            const ErrorScreen(), // Add a simple error screen
      ),
    ],
    errorBuilder: (context, state) =>
        const ErrorScreen(), // Handle navigation errors
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(UserService()), // Inject the AuthBloc with UserService
        ),
        BlocProvider(
          create: (context) =>
              CreateAccountAuthBloc(UserService()), // Provide the service here
        ),
        BlocProvider(
          create: (context) => PasswordVisibilityBloc(),
          child: SignInScreen(), // Provide the service here
        ),
        BlocProvider(
          create: (context) =>
              PasswordVisibilityBloc(), // Provide the service here
          child: CreateAccountScreen(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router, // Apply the GoRouter configuration
      ),
    );
  }
}

// A simple error screen for handling errors
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('Something went wrong!')),
    );
  }
}

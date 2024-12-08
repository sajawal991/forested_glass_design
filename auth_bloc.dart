import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../Integration_folder_with_backend/user_integration.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService userService;

  AuthBloc(this.userService) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        Response response =
            await userService.signIn(event.emailOrPhone, event.password);
        emit(AuthSuccess(response.data['message']));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}

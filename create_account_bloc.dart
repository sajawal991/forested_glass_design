import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:frontend/logic_folder/Bloc_folder/create_account/create_account_event.dart';
import 'package:frontend/logic_folder/Bloc_folder/create_account/create_account_state.dart';
import '../../Integration_folder_with_backend/user_integration.dart';

class CreateAccountAuthBloc
    extends Bloc<CreateAccountAuthEvent, CreateAccountAuthState> {
  final UserService userService;

  CreateAccountAuthBloc(this.userService) : super(CreateAccountAuthInitial()) {
    on<CreateAccountEvent>((event, emit) async {
      emit(CreateAccountAuthLoading());
      try {
        Response response = await userService.createAccount(
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          fullname: event.fullname,
          phonenumber: event.phonenumber,
          country: event.country,
          city: event.city,
          houseNumber: event.houseNo,
          streetNumber: event.streetNo,
          postalCode: event.postalCode,
          blockNumber: event.blockNo,
        );

        // Make sure to check if the response is successful and has a message
        if (response.data['success']) {
          emit(CreateAccountAuthSuccess(response.data['message']));
        } else {
          emit(CreateAccountAuthFailure(
              response.data['message'] ?? 'Unknown error'));
        }
      } on DioError catch (dioError) {
        emit(CreateAccountAuthFailure(
            dioError.response?.data['message'] ?? 'Failed to create account'));
      } catch (e) {
        emit(CreateAccountAuthFailure(e.toString()));
      }
    });
  }
}

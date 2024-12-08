import 'package:bloc/bloc.dart';
import 'eye_event.dart';
import 'eye_state.dart';

class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityInitial()) {
    on<TogglePasswordVisibility>((event, emit) {
      emit(PasswordVisibilityToggled(!state.isPasswordVisible));
    });
  }
}

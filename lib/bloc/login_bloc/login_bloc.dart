import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_validations/bloc/login_bloc/login_event.dart';
import 'package:flutter_bloc_clean_validations/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    String? error;
    
    if (email.isEmpty) {
      error = 'Email is required';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      error = 'Enter a valid email';
    }

    emit(state.copyWith(
      email: email,
      emailError: error,
      passwordError: state.passwordError
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = event.password;
    String? error;
    
    if (password.isEmpty) {
      error = 'Password is required';
    } else if (password.length < 5) {
      error = 'Password must be at least 5 characters';
    }

    emit(state.copyWith(
      password: password,
      passwordError: error,
      emailError: state.emailError
    ));
  }

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (!state.isValid) return;
    
    emit(state.copyWith(isSubmitting: true));
    
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call
      
       emit(LoginSuccess());
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
      ));
    }
  }
}
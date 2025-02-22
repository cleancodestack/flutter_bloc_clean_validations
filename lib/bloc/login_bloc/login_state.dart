class LoginState {
  final String email;
  final String password;
  final String? emailError;
  final String? passwordError;
  final bool isSubmitting;

  const LoginState({
    this.email = '',
    this.password = '',
    this.emailError,
    this.passwordError,
    this.isSubmitting = false,
  });

  bool get isValid => emailError == null && 
                      passwordError == null && 
                      email.isNotEmpty && 
                      password.isNotEmpty;

  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
    bool? isSubmitting,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailError: emailError,
      passwordError: passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
class LoginSuccess extends LoginState{
  LoginSuccess(): super(isSubmitting: false); 
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_validations/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc_clean_validations/bloc/login_bloc/login_event.dart';
import 'package:flutter_bloc_clean_validations/bloc/login_bloc/login_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Input Validations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showDialog(context: context, builder: (_){
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('You are logged in !'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => HomePage()));
                      },
                      child: const Text('OK')
                      )
                ],
              );
            });
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 200),
                  const Text(
                    "Welcome to BLoC Company",
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Please login to continue",
                    style: TextStyle(fontSize: 20)
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Email',
                      errorText: state.emailError,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => context.read<LoginBloc>()
                        .add(EmailChanged(value)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Password',
                      errorText: state.passwordError,
                    ),
                    obscureText: true,
                    onChanged: (value) => context.read<LoginBloc>()
                        .add(PasswordChanged(value)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state.isValid && !state.isSubmitting
                        ? () => context.read<LoginBloc>().add(LoginSubmitted())
                        : null,
                    child: state.isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "By signing in you agree to the terms and conditions"
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: Text("Hey there 👋🏻!"),
    ),
    body: Container(
      child: Center(
        child: Text('Welcome'))
    ),
   );
  }
}

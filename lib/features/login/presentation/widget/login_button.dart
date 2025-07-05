import 'package:buro_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:buro_app/features/login/presentation/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginButton extends StatefulWidget {
  final String userName;
  final String password;
  final VoidCallback onSuccess;
  final Function(String) onError;
  final VoidCallback onLoading;

  const LoginButton({
    super.key,
    required this.userName,
    required this.password,
    required this.onSuccess,
    required this.onError,
    required this.onLoading,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          widget.onSuccess();
        } else if (state is LoginError) {
          widget.onError(state.message);
        } else if (state is LoginLoading) {
          widget.onLoading();
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoginInitial(): {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    () {
                      if (widget.userName.isEmpty || widget.password.isEmpty) {
                        widget.onError('Por favor, completa todos los campos');
                      } else {
                        widget.onLoading();
                        context.read<LoginCubit>().login(widget.userName, widget.password);
                      }
                    },
                child: const Text('Iniciar sesión'),
              ),
            );
          }
          case LoginLoading(): {
            return const SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text('Iniciando sesión...'),
                  ],
                ),
              ),
            );
          }
          case LoginSuccess(model: final loginModel): {
            return const SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text('Iniciando sesión...'),
                  ],
                ),
              ),
            );
          }
          case LoginError(message: final msg): {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.userName.isEmpty || widget.password.isEmpty) {
                    widget.onError('Por favor, completa todos los campos');
                  } else {
                    widget.onLoading();
                    context.read<LoginCubit>().login(widget.userName, widget.password);
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
            );
          }
          default: return const SizedBox.shrink();
        }
      },
    );
  }
}
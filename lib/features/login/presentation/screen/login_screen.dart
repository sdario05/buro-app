import 'package:buro_app/di/injection.dart';
import 'package:buro_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:buro_app/features/login/presentation/screen/login_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => getIt<LoginCubit>(),
      child: const LoginScreenContent(),
    );
  }
}
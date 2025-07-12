import 'package:buro_app/di/injection.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_cubit.dart';
import 'package:buro_app/features/welcome/presentation/cubit/user_name_cubit.dart';
import 'package:buro_app/features/welcome/presentation/screens/welcome_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  final Function() onLogout;
  final Function(String) onModeSelect;

  const WelcomeScreen({
    super.key,
    required this.onLogout,
    required this.onModeSelect,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarouselCubit>(
            create: (context) => getIt<CarouselCubit>()
              ..getCarousel()
        ),
        BlocProvider<UserNameCubit>(
            create: (context) => getIt<UserNameCubit>()
              ..getUserName()
        )
      ],
      child: WelcomeScreenContent(
        onLogout: onLogout,
        onModeSelect: onModeSelect,
      ),
    );
  }
}
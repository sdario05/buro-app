import 'package:buro_app/di/injection.dart';
import 'package:buro_app/features/welcome/presentation/cubit/carousel_cubit.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
import 'package:buro_app/features/welcome/presentation/screen/welcome_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatelessWidget {

  const WelcomeScreen({
    super.key,
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
      child: const WelcomeScreenContent(),
    );
  }
}
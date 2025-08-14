import 'package:buro_app/di/injection.dart';
import 'package:buro_app/features/modes/explorer/welcome/presentation/screen/explorer_welcome_screen_content.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerWelcomeScreen extends StatelessWidget {

  const ExplorerWelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageCubit>(
            create: (context) => getIt<ImageCubit>()
              ..getImage(ImageType.explorerWelcome)
        ),
        BlocProvider<UserNameCubit>(
            create: (context) => getIt<UserNameCubit>()
              ..getUserName()
        )
      ],
      child: const ExplorerWelcomeScreenContent(),
    );
  }
}
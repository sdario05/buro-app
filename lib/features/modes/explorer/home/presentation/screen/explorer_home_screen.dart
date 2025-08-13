import 'package:buro_app/features/modes/explorer/home/presentation/cubit/explorer_job_cubit.dart';
import 'package:buro_app/features/modes/explorer/home/presentation/screen/explorer_home_screen_content.dart';
import 'package:buro_app/shared/cubit/user_name_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerHomeScreen extends StatelessWidget {

  final Function(String) onNavigate;
  final VoidCallback onBack;

  const ExplorerHomeScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<ExplorerJobCubit>(
          create: (context) => getIt<ExplorerJobCubit>()
            ..getJobs()
        ),
        BlocProvider<UserNameCubit>(
            create: (context) => getIt<UserNameCubit>()
              ..getUserName()
        )
      ],
      child: ExplorerHomeScreenContent(onNavigate: onNavigate, onBack: onBack),
    );
  }
}
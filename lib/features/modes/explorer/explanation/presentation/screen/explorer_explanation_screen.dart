import 'package:buro_app/features/modes/explorer/explanation/presentation/screen/explorer_explanation_screen_content.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerExplanationScreen extends StatelessWidget {

  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerExplanationScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GifAnimationCubit>(
      create: (context) => getIt<GifAnimationCubit>()
        ..getAnimation(GifType.explorerExplanation),
      child: ExplorerExplanationScreenContent(onNavigate: onNavigate, onBack: onBack),
    );
  }
}
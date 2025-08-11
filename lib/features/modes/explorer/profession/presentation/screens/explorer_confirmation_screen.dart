import 'package:buro_app/features/modes/explorer/profession/presentation/screens/explorer_confirmation_screen_content.dart';
import 'package:buro_app/shared/action/getgifanimation/presentation/cubit/gif_animation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerConfirmationScreen extends StatelessWidget {

  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;
  final List<String> professions; // Agregar esta línea

  const ExplorerConfirmationScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
    required this.professions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GifAnimationCubit>(
      create: (context) => getIt<GifAnimationCubit>()
        ..getAnimation(GifType.explorerProfessionSuccess),
      child: ExplorerConfirmationScreenContent(onNavigate: onNavigate, onBack: onBack, professions: professions,),
    );
  }
}
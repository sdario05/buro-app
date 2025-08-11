import 'package:buro_app/features/modes/explorer/profession/presentation/cubit/explorer_profession_cubit.dart';
import 'package:buro_app/features/modes/explorer/profession/presentation/screens/explorer_profession_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerProfessionScreen extends StatelessWidget {

  final Function(String, {dynamic data}) onNavigate;
  final Function() onBack;

  const ExplorerProfessionScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExplorerProfessionCubit>(
      create: (context) => getIt<ExplorerProfessionCubit>(),
      child: ExplorerProfessionScreenContent(onNavigate: onNavigate, onBack: onBack),
    );
  }
}
import 'package:buro_app/features/modes/explorer/contact/presentation/cubit/explorer_contact_cubit.dart';
import 'package:buro_app/features/modes/explorer/contact/presentation/screen/explorer_contact_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerContactScreen extends StatelessWidget {

  final Function(String) onNavigate;
  final Function() onBack;

  const ExplorerContactScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExplorerContactCubit>(
      create: (context) => getIt<ExplorerContactCubit>(),
      child: ExplorerContactScreenContent(onNavigate: onNavigate, onBack: onBack),
    );
  }
}
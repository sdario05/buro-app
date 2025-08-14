import 'package:buro_app/features/modes/explorer/profession/presentation/screen/explorer_confirmation_screen_content.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerConfirmationScreen extends StatelessWidget {
  final List<String> professions; // Agregar esta línea

  const ExplorerConfirmationScreen({
    super.key,
    required this.professions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCubit>(
      create: (context) => getIt<ImageCubit>()
        ..getImage(ImageType.explorerProfessionSuccess),
      child: ExplorerConfirmationScreenContent(professions: professions,),
    );
  }
}
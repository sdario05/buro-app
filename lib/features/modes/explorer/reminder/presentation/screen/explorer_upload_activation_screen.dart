import 'package:buro_app/features/modes/explorer/reminder/presentation/screen/explorer_upload_activation_screen_content.dart';
import 'package:buro_app/shared/action/getImage/presentation/cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buro_app/di/injection.dart';

class ExplorerUploadActivationScreen extends StatelessWidget {

  const ExplorerUploadActivationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImageCubit>(
      create: (context) => getIt<ImageCubit>()
        ..getImage(ImageType.explorerReminder),
      child: const ExplorerUploadActivationScreenContent(),
    );
  }
}